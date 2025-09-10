<template>
  <v-app id="inspire">
    <v-app-bar
      app
      clipped-left
      color="white"
      flat
      style="border-bottom: 1px solid #ddd !important;"
    >
      <v-app-bar-nav-icon @click.stop="drawer = !drawer"></v-app-bar-nav-icon>
      <v-toolbar-title class="font-weight-bold">Admin Console</v-toolbar-title>
      <v-spacer></v-spacer>
      <v-btn icon>
        <v-icon>mdi-bell-outline</v-icon>
      </v-btn>
      <v-menu offset-y>
        <template v-slot:activator="{ on, attrs }">
          <v-avatar size="40" class="ml-3" v-bind="attrs" v-on="on" style="cursor: pointer;">
            <img
              src="https://randomuser.me/api/portraits/men/85.jpg"
              alt="User"
            />
          </v-avatar>
        </template>
        <v-list>
          <v-list-item link to="/member/profile">
            <v-list-item-title>Profile</v-list-item-title>
          </v-list-item>
          <v-list-item link @click="logout">
            <v-list-item-title>Logout</v-list-item-title>
          </v-list-item>
        </v-list>
      </v-menu>
    </v-app-bar>

    <v-navigation-drawer
      v-model="drawer"
      app
      clipped
      class="translucent-blur-drawer"
    >
      <v-list nav dense>
        <v-list-item-group color="primary">
          <v-list-item
            v-for="item in items"
            :key="item.text"
            :to="item.to"
            link
          >
            <v-list-item-icon>
              <v-icon v-text="item.icon"></v-icon>
            </v-list-item-icon>
            <v-list-item-content>
              <v-list-item-title v-text="item.text"></v-list-item-title>
            </v-list-item-content>
          </v-list-item>
        </v-list-item-group>
      </v-list>
    </v-navigation-drawer>

    <v-main class="grey lighten-4">
      <!-- The content of the child pages will be rendered here -->
      <nuxt-child />
    </v-main>
  </v-app>
</template>

<script>
export default {
  name: 'AdminConsoleLayout',
  data: () => ({
    drawer: true,
    items: [
      { text: 'Stations', icon: 'mdi-cast-connected', to: '/admin/console/stations' },
      { text: 'Users', icon: 'mdi-account-group', to: '/admin/console/users' },
      { text: 'Wokwi DHT22', icon: 'mdi-chip', to: '/admin/console/sheet7_2' },
      { text: 'Test API', icon: 'mdi-code-braces-box', to: '/admin/console/iot_test' },
    ],
  }),
  methods: {
      logout() {
        // Assuming you have a logout action in your auth store
        this.$store.dispatch('auth/logout');
        this.$router.push('/');
      }
  }
};
</script>

<style>
.translucent-blur-drawer {
  background-color: rgba(255, 255, 255, 0.7) !important;
  backdrop-filter: blur(4px);
  -webkit-backdrop-filter: blur(4px);
}
.v-main {
  padding-top: 64px !important; /* Adjust based on app-bar height */
}
</style>
