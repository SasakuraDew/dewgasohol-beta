export default ({ store }) => {
  // This plugin runs only on the client side, once, when the app is initialized.
  if (!process.client) {
    return;
  }

  try {
    // Check if user data exists in localStorage
    const storedUser = localStorage.getItem('auth_user');

    if (storedUser) {
      // Parse the stored JSON string back into an object
      const user = JSON.parse(storedUser);

      // If user data is valid, commit it to the Vuex store
      if (user && user.id && user.email) {
        store.commit('auth/setUser', user);
      }
    }
  } catch (error) {
    console.error('Error initializing store from localStorage:', error);
    // If there's an error (e.g., corrupted data), clear the storage
    localStorage.removeItem('auth_user');
  }
};
