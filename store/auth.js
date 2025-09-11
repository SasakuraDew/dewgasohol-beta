
export const state = () => ({
  user: null
})

export const mutations = {
  setUser(state, user) {
    state.user = user
  }
}

export const actions = {
  async login({ commit }, { email, password }) {
    try {
      // ใช้ login.php ที่ส่ง user object กลับมา
      const loginResponse = await fetch('http://localhost/dewgasohol_beta/login.php', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ email, password })
      });

      const loginData = await loginResponse.json();

      if (loginData.status !== 'success' || !loginData.user) {
        throw new Error(loginData.message || 'Invalid email or password');
      }

      // รับ user object ตรงจาก response
      const user = {
        email: loginData.user.email,
        displayName: loginData.user.display_name
      };
      localStorage.setItem('user_email', user.email);
      commit('setUser', user);
      return user;
    } catch(e) {
      console.error('Login failed:', e);
      throw e;
    }
  },

  logout({ commit }) {
    localStorage.removeItem('auth_user') // อัปเดตให้ใช้ key ที่ถูกต้อง
    commit('setUser', null)
  },

  async tryAutoLogin({ commit }) {
    const email = localStorage.getItem('user_email')
    if (!email) {
      return
    }

    try {
        const displayNameResponse = await fetch(`http://localhost/dewgasohol_beta/deeplink_displayname.php?email=${encodeURIComponent(email)}`);
        const displayNameData = await displayNameResponse.json();

        if (!displayNameData || !displayNameData.display_name) {
          throw new Error('Could not fetch user display name.')
        }

        const user = {
            email: email,
            displayName: displayNameData.display_name
        }
        commit('setUser', user)
    } catch(e) {
        // If fetching user fails, clear login state
        localStorage.removeItem('user_email')
        commit('setUser', null)
    }
  }
}

export const getters = {
  isAuthenticated(state) {
    return !!state.user
  },
  loggedInUser(state) {
    return state.user
  }
}
