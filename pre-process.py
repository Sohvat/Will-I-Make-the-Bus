import pandas as pd
import numpy as np
from datetime import datetime
import os
import warnings
warnings.filterwarnings('ignore')

CONFIG = {
    'csv_path': './delays.csv',  
    'output_dir': 'processed_data',
    'min_samples_detailed': 10,     # Minimum observations for (route, stop, hour) group
    'min_samples_fallback': 20,     # Minimum observations for fallback groups
    'max_delay_minutes': 60,        # Remove delays beyond this (likely errors)
}


def load_data(csv_path):
    try:
        df = pd.read_csv(csv_path)
        return df
    
    except FileNotFoundError:
        print(f"ERROR: File not found: {csv_path}")
        exit(1)
    except Exception as e:
        print(f"ERROR loading file: {e}")
        exit(1)


def clean_data(df):
    
    original_len = len(df)
    
    print("\n🔄 Converting deviation to delay minutes...")
    if df['Deviation'].dtype == 'object':  # 'object' usually means string in pandas

    # Remove any commas, spaces, or non-numeric characters
        df['Deviation'] = df['Deviation'].astype(str).str.replace(',', '').str.strip()
        
        # Convert to numbers, setting errors to NaN
        df['Deviation'] = pd.to_numeric(df['Deviation'], errors='coerce')
        
        # Count how many couldn't be converted
        nan_count = df['Deviation'].isna().sum()
        if nan_count > 0:
            print(f"{nan_count:,} values couldn't be converted to numbers")
        
        # Remove rows where conversion failed
        df = df.dropna(subset=['Deviation'])
        df['delay_minutes'] = -df['Deviation'] / 60
   
    # 2. Parse scheduled time
    df['scheduled_datetime'] = pd.to_datetime(df['Scheduled Time'])

    
    # 3. Extract time features
    df['hour'] = df['scheduled_datetime'].dt.hour
    df['day_of_week'] = df['scheduled_datetime'].dt.dayofweek  # 0=Monday, 6=Sunday
    df['date'] = df['scheduled_datetime'].dt.date
    df['is_weekend'] = df['day_of_week'].isin([5, 6])
 
    # 4. Clean route and stop IDs
    df['route_id'] = df['Route Number'].astype(str).str.strip()
    df['stop_id'] = df['Stop Number'].astype(str).str.strip()

    
    # 5. Remove outliers (delays beyond threshold)
    df = df[df['delay_minutes'].abs() < CONFIG['max_delay_minutes']]
    
    
    # 6. Remove null values in critical columns
    before_null = len(df)
    df = df.dropna(subset=['route_id', 'stop_id', 'delay_minutes', 'hour'])
   
    

    print(f"Cleaning complete: {len(df):,} records remaining")
    print(f"   ({(len(df)/original_len*100):.1f}% of original data retained)")
    
    return df

#exploratory analysis
def analyze_data(df):

    # Overall delay distribution
    print("\nOVERALL DELAY DISTRIBUTION")
    print("-"*70)
    print(f"Mean delay:       {df['delay_minutes'].mean():>8.2f} min")
    print(f"Median delay:     {df['delay_minutes'].median():>8.2f} min")
    print(f"Std deviation:    {df['delay_minutes'].std():>8.2f} min")
    print(f"Min delay:        {df['delay_minutes'].min():>8.2f} min (early)")
    print(f"Max delay:        {df['delay_minutes'].max():>8.2f} min (late)")
    print(f"\nPercentiles:")
    print(f"  P10:            {df['delay_minutes'].quantile(0.10):>8.2f} min")
    print(f"  P25:            {df['delay_minutes'].quantile(0.25):>8.2f} min")
    print(f"  P50 (median):   {df['delay_minutes'].quantile(0.50):>8.2f} min")
    print(f"  P75:            {df['delay_minutes'].quantile(0.75):>8.2f} min")
    print(f"  P90:            {df['delay_minutes'].quantile(0.90):>8.2f} min")
    print(f"  P95:            {df['delay_minutes'].quantile(0.95):>8.2f} min")
    
    # Delays by hour
    hourly = df.groupby('hour')['delay_minutes'].agg(['mean', 'count']).round(2)
    hourly.columns = ['Avg Delay (min)', 'Count']
    print(hourly.to_string())
    
    # Delays by day type
    day_type = df.groupby('Day Type')['delay_minutes'].describe().round(2)
    print(day_type.to_string())
    
    # Top delayed routes
    by_route = df.groupby('route_id')['delay_minutes'].agg(['mean', 'std', 'count']).round(2)
    by_route.columns = ['Avg Delay (min)', 'Std Dev', 'Count']
    by_route = by_route[by_route['Count'] >= 50].sort_values('Avg Delay (min)', ascending=False)
    print(by_route.head(10).to_string())
    
    # Top early routes
    print(by_route.sort_values('Avg Delay (min)').head(10).to_string())
    
    # Check for predictability (correlation between hour and delay)
    correlation = df.groupby('hour')['delay_minutes'].mean().corr(pd.Series(range(24)))
    print(f"Correlation between hour and average delay: {correlation:.3f}")
    if abs(correlation) > 0.3:
        print(" Delays show time-of-day pattern (good for historical model)")
    elif abs(correlation) > 0.15:
        print("Delays show weak time-of-day pattern (model will have moderate accuracy)")
    else:
        print("Delays show little time-of-day pattern (rely more on live data)")

# ============================================
# STEP 4: COMPUTE DELAY STATISTICS
# ============================================
def compute_delay_stats(df, min_samples):

    print("\n" + "="*70)
    print("STEP 4: COMPUTING DELAY STATISTICS")
    print("="*70)
    
    # Group and compute statistics
    grouped = df.groupby(['route_id', 'stop_id', 'hour'])['delay_minutes']
    
    stats = grouped.agg([
        ('count', 'count'),
        ('mean', 'mean'),
        ('std', 'std'),
        ('min', 'min'),
        ('max', 'max'),
        ('p25', lambda x: x.quantile(0.25)),
        ('p50', lambda x: x.quantile(0.50)),
        ('p75', lambda x: x.quantile(0.75)),
        ('p90', lambda x: x.quantile(0.90)),
        ('p95', lambda x: x.quantile(0.95))
    ]).reset_index()
    

    
    # Filter sparse groups
    stats_filtered = stats[stats['count'] >= min_samples].copy()
    
    # Add metadata
    stats_filtered['fallback_level'] = 'detailed'
    
    
    return stats_filtered

# ============================================
# STEP 5: CREATE FALLBACK STATISTICS
# ============================================
def create_fallback_stats(df, min_samples):
  
    print("\n" + "="*70)
    print("STEP 5: CREATING FALLBACK STATISTICS")
    print("="*70)
    
    # FALLBACK LEVEL 1: Route + Hour (ignoring stop)
    route_hour = df.groupby(['route_id', 'hour'])['delay_minutes'].agg([
        ('count', 'count'),
        ('mean', 'mean'),
        ('std', 'std'),
        ('p50', lambda x: x.quantile(0.50)),
        ('p75', lambda x: x.quantile(0.75)),
        ('p90', lambda x: x.quantile(0.90))
    ]).reset_index()
    
    route_hour = route_hour[route_hour['count'] >= min_samples].copy()
    route_hour['fallback_level'] = 'route_hour'
    route_hour['stop_id'] = 'ANY'
    
    # FALLBACK LEVEL 2: Route only (ignoring stop and hour)
    route_only = df.groupby(['route_id'])['delay_minutes'].agg([
        ('count', 'count'),
        ('mean', 'mean'),
        ('std', 'std'),
        ('p50', lambda x: x.quantile(0.50)),
        ('p75', lambda x: x.quantile(0.75)),
        ('p90', lambda x: x.quantile(0.90))
    ]).reset_index()
    
    route_only = route_only[route_only['count'] >= min_samples].copy()
    route_only['fallback_level'] = 'route_only'
    route_only['stop_id'] = 'ANY'
    route_only['hour'] = -1

    
    return route_hour, route_only


def save_stats(stats_detailed, stats_route_hour, stats_route_only, output_dir):
    
    # Create output directory
    os.makedirs(output_dir, exist_ok=True)

    
    # Save detailed stats
    detailed_path = os.path.join(output_dir, 'delay_stats_detailed.csv')
    stats_detailed.to_csv(detailed_path, index=False)
    
    # Save route-hour stats
    route_hour_path = os.path.join(output_dir, 'delay_stats_route_hour.csv')
    stats_route_hour.to_csv(route_hour_path, index=False)
   
    # Save route-only stats
    route_only_path = os.path.join(output_dir, 'delay_stats_route_only.csv')
    stats_route_only.to_csv(route_only_path, index=False)
   

def main():
    
    # Step 1: Load data
    df = load_data(CONFIG['csv_path'])
    
    # Step 2: Clean data
    df = clean_data(df)
    
    # Step 3: Exploratory analysis
    analyze_data(df)
    
    # Step 4: Compute detailed statistics
    stats_detailed = compute_delay_stats(df, CONFIG['min_samples_detailed'])
    
    # Step 5: Create fallback statistics
    stats_route_hour, stats_route_only = create_fallback_stats(df, CONFIG['min_samples_fallback'])
    
    # Step 6: Save results
    save_stats(stats_detailed, stats_route_hour, stats_route_only, CONFIG['output_dir'])
    

if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        print("\n\nScript interrupted by user")
    except Exception as e:
        print(f"\n\ERROR: {e}")
        import traceback
        traceback.print_exc()