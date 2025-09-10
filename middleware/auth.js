export default function ({ store, redirect }) {
  // Check if the user is authenticated
  if (!store.getters.isAuthenticated) {
    return redirect('/login')
  }
}
