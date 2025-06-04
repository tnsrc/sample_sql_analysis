#!/usr/bin/env python3
"""
Decision Points Analyzer for SQL Stored Procedures

This script analyzes SQL stored procedures and functions to identify and categorize
all decision points (branching logic) that affect control flow and complexity.

Universal approach works across all business domains and SQL variants.
"""

import re
import sys
from typing import List, Dict, Tuple, Any
from dataclasses import dataclass
from pathlib import Path

@dataclass
class DecisionPoint:
    """Represents a single decision point in SQL code"""
    type: str
    line_number: int
    content: str
    complexity_weight: int
    condition_count: int
    nesting_level: int
    context: str

class DecisionPointsAnalyzer:
    """Analyzes SQL code to identify and categorize decision points"""
    
    def __init__(self):
        # Decision point patterns with complexity weights
        self.decision_patterns = {
            # IF statements and conditionals
            'if_statement': {
                'pattern': r'\bIF\s+([^B]+?)\s+BEGIN',
                'weight': 2,
                'description': 'IF conditional block'
            },
            'if_else': {
                'pattern': r'\bIF\s+([^B]+?)\s+ELSE',
                'weight': 1,
                'description': 'IF-ELSE branch'
            },
            'else_if': {
                'pattern': r'\bELSE\s+IF\s+([^B]+?)',
                'weight': 1,
                'description': 'ELSE IF branch'
            },
            
            # CASE statements
            'case_when': {
                'pattern': r'\bCASE\s+.*?\bWHEN\s+([^T]+?)\s+THEN',
                'weight': 1,
                'description': 'CASE WHEN condition'
            },
            'case_expression': {
                'pattern': r'\bCASE\s+(\w+)\s+WHEN',
                'weight': 2,
                'description': 'CASE expression'
            },
            
            # WHILE and loop conditions
            'while_loop': {
                'pattern': r'\bWHILE\s+([^B]+?)\s+BEGIN',
                'weight': 3,
                'description': 'WHILE loop condition'
            },
            
            # Complex WHERE clauses
            'where_and': {
                'pattern': r'\bWHERE\s+.*?\bAND\b',
                'weight': 1,
                'description': 'WHERE clause with AND'
            },
            'where_or': {
                'pattern': r'\bWHERE\s+.*?\bOR\b',
                'weight': 2,
                'description': 'WHERE clause with OR'
            },
            'where_in': {
                'pattern': r'\bWHERE\s+.*?\bIN\s*\(',
                'weight': 1,
                'description': 'WHERE IN condition'
            },
            'where_exists': {
                'pattern': r'\bWHERE\s+.*?\bEXISTS\s*\(',
                'weight': 2,
                'description': 'WHERE EXISTS condition'
            },
            'where_not_exists': {
                'pattern': r'\bWHERE\s+.*?\bNOT\s+EXISTS\s*\(',
                'weight': 2,
                'description': 'WHERE NOT EXISTS condition'
            },
            
            # EXISTS patterns (standalone)
            'exists_condition': {
                'pattern': r'\bEXISTS\s*\(',
                'weight': 2,
                'description': 'EXISTS condition'
            },
            'not_exists_condition': {
                'pattern': r'\bNOT\s+EXISTS\s*\(',
                'weight': 2,
                'description': 'NOT EXISTS condition'
            },
            
            # HAVING clauses
            'having_clause': {
                'pattern': r'\bHAVING\s+([^G;]+)',
                'weight': 2,
                'description': 'HAVING condition'
            },
            
            # JOIN conditions
            'inner_join': {
                'pattern': r'\bINNER\s+JOIN\s+.*?\bON\s+([^W;]+)',
                'weight': 1,
                'description': 'INNER JOIN condition'
            },
            'left_join': {
                'pattern': r'\bLEFT\s+JOIN\s+.*?\bON\s+([^W;]+)',
                'weight': 1,
                'description': 'LEFT JOIN condition'
            },
            'right_join': {
                'pattern': r'\bRIGHT\s+JOIN\s+.*?\bON\s+([^W;]+)',
                'weight': 1,
                'description': 'RIGHT JOIN condition'
            },
            
            # Exception handling
            'try_catch': {
                'pattern': r'\bBEGIN\s+TRY\b',
                'weight': 2,
                'description': 'TRY-CATCH block'
            },
            'raiserror': {
                'pattern': r'\bRAISERROR\s*\(',
                'weight': 1,
                'description': 'Error raising condition'
            },
            
            # Dynamic conditions
            'dynamic_sql': {
                'pattern': r'\bEXEC\s*\(\s*@',
                'weight': 3,
                'description': 'Dynamic SQL execution'
            },
            
            # Subquery conditions
            'subquery': {
                'pattern': r'\(\s*SELECT\s+.*?\bWHERE\b',
                'weight': 2,
                'description': 'Subquery with condition'
            },
            
            # GOTO statements
            'goto_statement': {
                'pattern': r'\bGOTO\s+(\w+)',
                'weight': 2,
                'description': 'GOTO statement'
            },
            
            # Comparison operators in conditions
            'comparison_operators': {
                'pattern': r'\b(=|<>|!=|>|<|>=|<=)\s',
                'weight': 1,
                'description': 'Comparison operation'
            }
        }
        
        # Logical operators that increase condition complexity
        self.logical_operators = ['AND', 'OR', 'NOT', 'BETWEEN', 'LIKE', 'IN', 'EXISTS']
    
    def analyze_file(self, file_path: str) -> Dict[str, Any]:
        """Analyze a SQL file for decision points"""
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.read()
        except Exception as e:
            return {'error': f'Could not read file: {e}'}
        
        return self.analyze_content(content, file_path)
    
    def analyze_content(self, content: str, source_name: str = 'SQL Content') -> Dict[str, Any]:
        """Analyze SQL content for decision points"""
        lines = content.split('\n')
        decision_points = []
        
        # Track nesting levels
        nesting_level = 0
        in_procedure = False
        current_procedure = None
        procedure_nesting_start = 0
        
        for line_num, line in enumerate(lines, 1):
            line_clean = line.strip().upper()
            original_line = line.strip()
            
            # Track procedure boundaries
            if re.search(r'\b(CREATE|ALTER)\s+(PROCEDURE|FUNCTION)\b', line_clean):
                in_procedure = True
                proc_match = re.search(r'\b(PROCEDURE|FUNCTION)\s+(\w+)', line_clean)
                current_procedure = proc_match.group(2) if proc_match else 'Unknown'
                nesting_level = 0
                procedure_nesting_start = 0
            
            # Track nesting level
            if 'BEGIN' in line_clean:
                nesting_level += 1
                if in_procedure and procedure_nesting_start == 0:
                    procedure_nesting_start = nesting_level
            
            if re.search(r'\bEND\b', line_clean):
                if nesting_level > 0:
                    nesting_level -= 1
                # Only exit procedure if we're back to the procedure's starting level
                if in_procedure and nesting_level < procedure_nesting_start:
                    in_procedure = False
                    current_procedure = None
                    procedure_nesting_start = 0
            
            # Skip if not in a procedure/function
            if not in_procedure:
                continue
            
            # Find decision points
            for pattern_name, pattern_info in self.decision_patterns.items():
                # Special handling for comparison operators to avoid too many matches
                if pattern_name == 'comparison_operators':
                    # Only count comparisons in IF, WHERE, HAVING, ON clauses
                    if any(keyword in line_clean for keyword in ['IF ', 'WHERE ', 'HAVING ', ' ON ', 'WHEN ']):
                        matches = re.finditer(pattern_info['pattern'], line_clean, re.IGNORECASE)
                    else:
                        continue
                else:
                    matches = re.finditer(pattern_info['pattern'], line_clean, re.IGNORECASE | re.DOTALL)
                
                for match in matches:
                    condition = match.group(1) if match.groups() else match.group(0)
                    condition_count = self._count_conditions(condition)
                    
                    decision_point = DecisionPoint(
                        type=pattern_name,
                        line_number=line_num,
                        content=original_line,
                        complexity_weight=pattern_info['weight'],
                        condition_count=condition_count,
                        nesting_level=nesting_level,
                        context=current_procedure or 'Global'
                    )
                    
                    decision_points.append(decision_point)
        
        return self._generate_analysis_report(decision_points, source_name)
    
    def _count_conditions(self, condition_text: str) -> int:
        """Count the number of logical conditions in a condition string"""
        if not condition_text:
            return 1
        
        count = 1  # Base condition
        for operator in self.logical_operators:
            count += len(re.findall(rf'\b{operator}\b', condition_text.upper()))
        
        return count
    
    def _generate_analysis_report(self, decision_points: List[DecisionPoint], source_name: str) -> Dict[str, Any]:
        """Generate comprehensive analysis report"""
        if not decision_points:
            return {
                'source': source_name,
                'total_decision_points': 0,
                'complexity_score': 0,
                'complexity_rating': 'None',
                'metrics': {
                    'max_nesting_level': 0,
                    'avg_nesting_level': 0,
                    'avg_conditions_per_point': 0,
                    'unique_decision_types': 0,
                    'procedures_analyzed': 0
                },
                'decision_point_types': {},
                'by_procedure': {},
                'detailed_points': [],
                'analysis': 'No decision points found'
            }
        
        # Group by type
        by_type = {}
        by_context = {}
        total_complexity = 0
        max_nesting = 0
        
        for dp in decision_points:
            # By type
            if dp.type not in by_type:
                by_type[dp.type] = []
            by_type[dp.type].append(dp)
            
            # By context (procedure/function)
            if dp.context not in by_context:
                by_context[dp.context] = []
            by_context[dp.context].append(dp)
            
            # Complexity calculation (weight * condition_count * nesting_factor)
            nesting_factor = 1 + (dp.nesting_level * 0.5)
            total_complexity += dp.complexity_weight * dp.condition_count * nesting_factor
            max_nesting = max(max_nesting, dp.nesting_level)
        
        # Calculate metrics
        avg_conditions_per_point = sum(dp.condition_count for dp in decision_points) / len(decision_points)
        avg_nesting_level = sum(dp.nesting_level for dp in decision_points) / len(decision_points)
        
        # Complexity rating
        complexity_rating = self._get_complexity_rating(total_complexity, len(decision_points))
        
        # Generate detailed breakdown
        type_summary = {}
        for dp_type, points in by_type.items():
            pattern_info = self.decision_patterns[dp_type]
            type_summary[dp_type] = {
                'count': len(points),
                'description': pattern_info['description'],
                'base_weight': pattern_info['weight'],
                'total_complexity': sum(p.complexity_weight * p.condition_count * (1 + p.nesting_level * 0.5) for p in points),
                'lines': [p.line_number for p in points]
            }
        
        context_summary = {}
        for context, points in by_context.items():
            context_complexity = sum(p.complexity_weight * p.condition_count * (1 + p.nesting_level * 0.5) for p in points)
            context_summary[context] = {
                'decision_points': len(points),
                'complexity_score': round(context_complexity, 2),
                'max_nesting': max(p.nesting_level for p in points),
                'types_used': list(set(p.type for p in points))
            }
        
        return {
            'source': source_name,
            'total_decision_points': len(decision_points),
            'complexity_score': round(total_complexity, 2),
            'complexity_rating': complexity_rating,
            'metrics': {
                'max_nesting_level': max_nesting,
                'avg_nesting_level': round(avg_nesting_level, 2),
                'avg_conditions_per_point': round(avg_conditions_per_point, 2),
                'unique_decision_types': len(by_type),
                'procedures_analyzed': len(by_context)
            },
            'decision_point_types': type_summary,
            'by_procedure': context_summary,
            'detailed_points': [
                {
                    'line': dp.line_number,
                    'type': dp.type,
                    'description': self.decision_patterns[dp.type]['description'],
                    'content': dp.content,
                    'condition_count': dp.condition_count,
                    'nesting_level': dp.nesting_level,
                    'context': dp.context,
                    'complexity_contribution': round(dp.complexity_weight * dp.condition_count * (1 + dp.nesting_level * 0.5), 2)
                } for dp in decision_points
            ]
        }
    
    def _get_complexity_rating(self, total_complexity: float, point_count: int) -> str:
        """Determine complexity rating based on metrics"""
        if point_count == 0:
            return 'None'
        
        avg_complexity = total_complexity / point_count
        
        if avg_complexity < 2:
            return 'Low'
        elif avg_complexity < 5:
            return 'Moderate'
        elif avg_complexity < 10:
            return 'High'
        else:
            return 'Very High'
    
    def print_analysis(self, analysis: Dict[str, Any], show_details: bool = False):
        """Print formatted analysis results"""
        if 'error' in analysis:
            print(f"ERROR: {analysis['error']}")
            return
        
        print("=" * 80)
        print(f"DECISION POINTS ANALYSIS: {analysis['source']}")
        print("=" * 80)
        
        print(f"\n📊 SUMMARY:")
        print(f"  Total Decision Points: {analysis['total_decision_points']}")
        print(f"  Complexity Score: {analysis['complexity_score']}")
        print(f"  Complexity Rating: {analysis['complexity_rating']}")
        
        metrics = analysis['metrics']
        print(f"\n📈 METRICS:")
        print(f"  Max Nesting Level: {metrics['max_nesting_level']}")
        print(f"  Avg Nesting Level: {metrics['avg_nesting_level']}")
        print(f"  Avg Conditions per Point: {metrics['avg_conditions_per_point']}")
        print(f"  Unique Decision Types: {metrics['unique_decision_types']}")
        print(f"  Procedures Analyzed: {metrics['procedures_analyzed']}")
        
        print(f"\n🏷️  DECISION POINT TYPES:")
        for dp_type, info in analysis['decision_point_types'].items():
            print(f"  {dp_type.upper()}: {info['count']} occurrences")
            print(f"    └─ {info['description']}")
            print(f"    └─ Complexity: {info['total_complexity']:.1f} | Lines: {info['lines'][:5]}{'...' if len(info['lines']) > 5 else ''}")
        
        print(f"\n🔧 BY PROCEDURE/FUNCTION:")
        for context, info in analysis['by_procedure'].items():
            print(f"  {context}:")
            print(f"    └─ Decision Points: {info['decision_points']}")
            print(f"    └─ Complexity Score: {info['complexity_score']}")
            print(f"    └─ Max Nesting: {info['max_nesting']}")
            print(f"    └─ Types: {', '.join(info['types_used'])}")
        
        if show_details:
            print(f"\n📋 DETAILED BREAKDOWN:")
            for point in analysis['detailed_points']:
                print(f"  Line {point['line']:3d}: {point['type'].upper()}")
                print(f"    └─ {point['description']}")
                print(f"    └─ Context: {point['context']} | Nesting: {point['nesting_level']} | Conditions: {point['condition_count']}")
                print(f"    └─ Code: {point['content'][:80]}{'...' if len(point['content']) > 80 else ''}")
                print(f"    └─ Complexity Contribution: {point['complexity_contribution']}")
                print()

def main():
    """Main CLI interface"""
    if len(sys.argv) < 2:
        print("Usage: python decision_points_analyzer.py <sql_file> [--details]")
        print("\nAnalyzes SQL stored procedures for decision points and branching complexity.")
        print("\nOptions:")
        print("  --details    Show detailed breakdown of each decision point")
        print("\nExample:")
        print("  python decision_points_analyzer.py my_procedure.sql")
        print("  python decision_points_analyzer.py my_procedure.sql --details")
        sys.exit(1)
    
    file_path = sys.argv[1]
    show_details = '--details' in sys.argv
    
    if not Path(file_path).exists():
        print(f"ERROR: File '{file_path}' not found.")
        sys.exit(1)
    
    analyzer = DecisionPointsAnalyzer()
    print(f"🔍 Analyzing decision points in: {file_path}")
    print("⏳ Processing...")
    
    analysis = analyzer.analyze_file(file_path)
    analyzer.print_analysis(analysis, show_details)
    
    print(f"\n✅ Analysis complete!")
    
    # Provide recommendations based on complexity
    complexity_score = analysis.get('complexity_score', 0)
    if complexity_score > 50:
        print(f"\n💡 RECOMMENDATIONS:")
        print(f"  • Consider breaking down complex procedures")
        print(f"  • Review deeply nested conditional logic")
        print(f"  • Extract reusable functions for common conditions")
        print(f"  • Consider refactoring procedures with high decision point density")

if __name__ == '__main__':
    main() 