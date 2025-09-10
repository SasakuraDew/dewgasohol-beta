export default function ({ store, redirect }) {
  // Check if the user is authenticated
  if (!store.getters.isAuthenticated) {
    return redirect('/deep_link/user_signin')
  }
}
