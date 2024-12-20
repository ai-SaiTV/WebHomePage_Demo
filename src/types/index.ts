// Add these types to the existing types file

export interface ErrorType {
  type: string;
  count: number;
  percentage: number;
}

export interface Exercise {
  id: string;
  type: 'choice' | 'fill' | 'short';
  question: string;
  options?: string[];
  answer: string;
  difficulty: 'easy' | 'medium' | 'hard';
}