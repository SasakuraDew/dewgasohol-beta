<template>
  <v-app style="height: auto; margin: 0 auto;">   
  <v-app-bar style="height: auto; margin: auto; background-color: rgba(255,255,255,0.2); backdrop-filter: blur(2.3px); -webkit-backdrop-filter: blur(2px);" app>
      <v-toolbar-title class="black--text" style="font-weight: bold; font-size: 20px; flex-grow: 1; white-space: normal; overflow: visible; text-overflow: unset; display: flex; align-items: center;">
  <img src="/Image 10_12_02.png" alt="Dewgasohol Logo" style="height:40px; width:auto; margin-right:12px; display:inline-block; vertical-align:middle; border-radius:8px; box-shadow:0 2px 8px rgba(0,0,0,0.08);" />
  <span style="font-weight:bold; font-size:20px; min-width:100px; text-align:center; display:inline-flex; align-items:center; justify-content:center; width:100%;">DEWGASOHOL</span>
      </v-toolbar-title>
      <script type="text/javascript" async src="https://tenor.com/embed.js"></script>
  <v-tabs tabs slider-color="rgba(255, 255, 255, 0)">
        <!-- <v-tab class="black--text" disabled style="font-weight:bold; font-size:20px; min-width:140px;">DEWGASOHOL</v-tab> -->
        <v-tab class="black--text" to="/">
          <v-icon left class="mr-1">mdi-home</v-icon>
          หน้าหลัก
        </v-tab>
        <v-tab class="black--text" to="/oil_prices">
          <v-icon left class="mr-1">mdi-currency-usd</v-icon>
          ราคาน้ำมัน
        </v-tab>
        <v-tab class="black--text" to="/coupons">
          <v-icon left class="mr-1">mdi-ticket-percent</v-icon>
          คูปอง
        </v-tab>
        <v-tab class="black--text" to="/contact">
          <v-icon left class="mr-1">mdi-phone</v-icon>
          ติดต่อเรา
        </v-tab>
<!-- <v-tab class="black--text" to="/news">News</v-tab> -->
        <!-- <v-tab class="black--text" to="/security/blank">Blog</v-tab> -->
        <!-- <v-tab class="black--text" to="/admin/console">test</v-tab> -->
        <!-- <v-tab class="black--text" to="/forms">Forms</v-tab> -->
        <!-- <v-tab class="black--text" to="/about">about</v-tab> -->
         <v-spacer></v-spacer>
          <v-menu v-if="isAdmin" offset-y transition="scroll-y-transition">
            <template v-slot:activator="{ on, attrs }">
              <v-btn
                text
                class="black--text"
                v-bind="attrs"
                v-on="on"
                style="padding: 16px; display: flex; align-items: center; justify-content: center; min-width: 100px; font-size: 14px; height: auto;"
              >
                <v-icon left style="margin-right:4px; font-size: 24px;">mdi-wrench</v-icon>
                Console
                <v-icon small style="margin-left:8px;">mdi-menu-down</v-icon>
              </v-btn>
            </template>
            <v-list>
              <v-list-item link to="/console/stations">
                <v-list-item-icon><v-icon>mdi-gas-station</v-icon></v-list-item-icon>
                <v-list-item-title>Stations</v-list-item-title>
              </v-list-item>
              <v-list-item link to="/console/users">
                <v-list-item-icon><v-icon>mdi-account-group</v-icon></v-list-item-icon>
                <v-list-item-title>Users</v-list-item-title>
              </v-list-item>
              <v-list-item link to="/console/sheet7_2">
                <v-list-item-icon><v-icon>mdi-thermometer</v-icon></v-list-item-icon>
                <v-list-item-title>Wokwi Get DHT22</v-list-item-title>
              </v-list-item>
              <v-list-item link to="/console/iot_test">
                <v-list-item-icon><v-icon>mdi-api</v-icon></v-list-item-icon>
                <v-list-item-title>test API</v-list-item-title>
              </v-list-item>
              <v-list-item link to="/console/stock">
                <v-list-item-icon><v-icon>mdi-oil</v-icon></v-list-item-icon>
                <v-list-item-title>Stock</v-list-item-title>
              </v-list-item>
            </v-list>
          </v-menu>
        
        <!-- <v-tab class="black--text" to="/test">Test PAGE</v-tab> -->
        <!-- <v-tab class="black--text" to="/">Sign UP</v-tab> -->
        <!-- <v-tab class="black--text" to="/login">Login Member</v-tab> -->
        <v-tab
          v-if="!isAuthenticated"
          class="black--text"
          to="/deep_link/user_signin"
        >
          <v-icon left class="mr-1" style="font-size: 28px;">mdi-account-circle</v-icon>
          Sign IN
        </v-tab>
        <v-tab
          v-else
          class="black--text"
          to="/deep_link/profile"
        >
          <v-icon left class="mr-1" style="font-size: 28px;">mdi-account-circle</v-icon>
          <span style="font-variant: normal; text-transform: none;">{{ loggedInUser.display_name }}</span>
        </v-tab>
      </v-tabs>
  <!-- <pre style="color:red; background: #fff; font-size: 12px;">{{ loggedInUser }}</pre> -->
      <v-btn v-if="isAuthenticated" icon @click.stop="drawer = !drawer">
          <v-icon color="black">mdi-menu</v-icon>
        </v-btn>
    </v-app-bar>
    <v-navigation-drawer
      v-model="drawer"
      right
      temporary
      app
      style="max-width: auto; height: auto; margin: 0 auto;"
      width="300"
      fixed
      clipped
      disable-resize-watcher
      class="white drawer-blur">
  <v-list class="drawer-blur">
  <v-list-item class="drawer-blur" v-if="isAuthenticated">
          <v-list-item-avatar>
            <v-img src="/This is number 357.jpg"></v-img>
          </v-list-item-avatar>
          <v-list-item-content class="black--text">
            <v-list-item-title class="headline">{{ loggedInUser.display_name }}</v-list-item-title>
            <v-list-item-subtitle>{{ loggedInUser.email }}</v-list-item-subtitle>
          </v-list-item-content>
        </v-list-item>
        <v-divider></v-divider>
  <v-list-item link class="black--text drawer-blur" to="/deep_link/profile">
          <v-list-item-icon><v-icon class="black--text">mdi-account</v-icon></v-list-item-icon>
          <v-list-item-title>โปรไฟล์</v-list-item-title>
        </v-list-item>
  <v-list-item link class="black--text drawer-blur">
          <v-list-item-icon><v-icon class="black--text">mdi-cog</v-icon></v-list-item-icon>
          <v-list-item-title>ตั้งค่า</v-list-item-title>
        </v-list-item>
  <v-list-item v-if="isAuthenticated" link class="black--text drawer-blur" @click="logout">
          <v-list-item-icon><v-icon class="black--text">mdi-logout</v-icon></v-list-item-icon>
          <v-list-item-title>ออกจากระบบ</v-list-item-title>
        </v-list-item>
      </v-list>
    </v-navigation-drawer>
    <v-main>
      <nuxt />
    </v-main>
  </v-app>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  data() {
    return {
      drawer: false,
    }
  },
  computed: {
    ...mapGetters('auth', ['isAuthenticated', 'loggedInUser']),
    isAdmin() {
      return this.isAuthenticated && this.loggedInUser && this.loggedInUser.email === 'admin@outlook.com';
    }
  },
  created() {
    this.$store.dispatch('auth/tryAutoLogin')
  },
  methods: {
    logout() {
      this.$store.dispatch('auth/logout');
      this.$router.push('/');
    }
  }
}
</script>

<style>
/* Make everything in the navigation drawer transparent and blurred */
.drawer-blur {
  background-color: rgba(255,255,255,0.2) !important;
  backdrop-filter: blur(2px) !important;
  -webkit-backdrop-filter: blur(2px) !important;
}
</style>