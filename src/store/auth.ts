import { defineStore } from 'pinia';

export const useAuthStore = defineStore('auth', {
  state: () => ({
    isAuthenticated: false,
    user: null as string | null,
  }),
  actions: {
    login(username: string) {
      this.isAuthenticated = true;
      this.user = username;
    },
    logout() {
      this.isAuthenticated = false;
      this.user = null;
    },
  },
});