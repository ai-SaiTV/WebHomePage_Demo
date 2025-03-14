export interface User {
  username: string;
  password: string;
}

export interface ExamRecord {
  id: number;
  date: string;
  subject: string;
  score: number;
  details: string;
}