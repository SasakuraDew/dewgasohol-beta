export default function ({ store, redirect }) {
  // Check if the user is authenticated and is an admin.

  const user = store.state.auth.user

  if (!user || user.email !== 'admin@outlook.com') {
    return redirect('/login') // Or to a non-authorized page
  }
}

