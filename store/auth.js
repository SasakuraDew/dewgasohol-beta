
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
      // 1. Authenticate user with your PHP backend
      const loginResponse = await fetch('http://localhost/dewgasohol_beta/deeplink_scr_in.php', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ email, password })
      })

      const loginData = await loginResponse.json()

      if (!loginData.success) {
        throw new Error('Invalid email or password')
      }

      // 2. If login is successful, fetch the display name
      const displayNameResponse = await fetch(`http://localhost/dewgasohol_beta/deeplink_displayname.php?email=${encodeURIComponent(email)}`);
      const displayNameData = await displayNameResponse.json();

      if (!displayNameData || !displayNameData.display_name) {
        throw new Error('Could not fetch user display name.')
      }

      // 3. Create user object and save email to localStorage
      const user = {
        email: email,
        displayName: displayNameData.display_name
      }
      localStorage.setItem('user_email', email)

      // 4. Commit user to the store
      commit('setUser', user)

      return user; // Return user data on success

    } catch(e) {
        // If fetching user fails, do not clear login state. This prevents the user
        // from being logged out if the backend call fails during auto-login.
        // localStorage.removeItem('user_email')
        // commit('setUser', null)
        console.error('Auto login failed:', e); // Log the error for debugging
    }
  },

  logout({ commit }) {
    localStorage.removeItem('user_email')
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
