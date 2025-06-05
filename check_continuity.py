#!/usr/bin/env python3
"""
Check line number continuity in the adaptive analysis file
"""

import re
import sys

def extract_line_ranges(filename):
    """Extract line ranges from the analysis file"""
    ranges = []
    
    with open(filename, 'r') as f:
        content = f.read()
    
    # Find all "Lines: X-Y" patterns
    pattern = r'Lines: (\d+)-(\d+)'
    matches = re.findall(pattern, content)
    
    for start_str, end_str in matches:
        start = int(start_str)
        end = int(end_str)
        ranges.append((start, end))
    
    return sorted(ranges)

def check_continuity(ranges):
    """Check for gaps and overlaps in line ranges"""
    print(f'Checking line number continuity...')
    print(f'Total chunks found: {len(ranges)}')
    print(f'First chunk: lines {ranges[0][0]}-{ranges[0][1]}')
    print(f'Last chunk: lines {ranges[-1][0]}-{ranges[-1][1]}')
    print()
    
    gaps = []
    overlaps = []
    
    for i in range(len(ranges) - 1):
        current_end = ranges[i][1]
        next_start = ranges[i+1][0]
        
        if next_start > current_end + 1:
            gap_start = current_end + 1
            gap_end = next_start - 1
            gaps.append(f'Gap between chunk {i+1} and {i+2}: lines {gap_start}-{gap_end} missing')
        elif next_start <= current_end:
            overlaps.append(f'Overlap: chunk {i+1} ends at {current_end}, chunk {i+2} starts at {next_start}')
    
    if gaps:
        print(f'❌ Found {len(gaps)} gaps:')
        for gap in gaps:
            print(f'   {gap}')
    else:
        print('✅ NO GAPS FOUND - All line numbers are continuous!')
    
    print()
    
    if overlaps:
        print(f'❌ Found {len(overlaps)} overlaps:')
        for overlap in overlaps:
            print(f'   {overlap}')
    else:
        print('✅ NO OVERLAPS FOUND - All chunks have clean boundaries!')
    
    print()
    
    # Calculate total lines covered
    total_lines_covered = sum(end - start + 1 for start, end in ranges)
    expected_lines = ranges[-1][1]  # Should match the last line number
    
    print(f'Total lines covered: {total_lines_covered}')
    print(f'Expected lines (1 to {expected_lines}): {expected_lines}')
    
    if total_lines_covered == expected_lines and not gaps and not overlaps:
        print('✅ PERFECT COVERAGE - All source code lines are included exactly once!')
    else:
        print('❌ Coverage issues detected')
    
    return len(gaps) == 0 and len(overlaps) == 0

if __name__ == "__main__":
    filename = "adaptive_analysis.md"
    ranges = extract_line_ranges(filename)
    is_continuous = check_continuity(ranges)
    
    sys.exit(0 if is_continuous else 1) 