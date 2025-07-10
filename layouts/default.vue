<template>
  <v-app style="height: auto; margin: 0 auto;">   
    <v-app-bar style=" height: auto; margin: auto;" app>
      <v-toolbar-title class="black--text" style="font-weight: bold; font-size: 20px; flex-grow: 1; white-space: normal; overflow: visible; text-overflow: unset; display: flex; align-items: center;">
        <img src="/1994408.jpg" alt="Logo" style="height: 40px; margin-right: 12px;">
        <span style="font-weight:bold; font-size:20px; min-width:140px;">DEWGASOHOL **BATA**</span>
      </v-toolbar-title>
      <v-tabs tabs slider-color="black">
        <!-- <v-tab class="black--text" disabled style="font-weight:bold; font-size:20px; min-width:140px;">DEWGASOHOL</v-tab> -->
        <v-tab class="black--text" to="/home">Home</v-tab>
        <v-tab class="black--text" to="/news">News</v-tab>
        <v-tab class="black--text" to="/contact">Contact</v-tab>
        <v-tab class="black--text" to="/forms">Forms</v-tab>
        <v-spacer></v-spacer>
        <v-tab class="black--text" to="/test">Test PAGE</v-tab>
        <v-tab class="black--text" to="/">Sign UP</v-tab>
        <v-tab class="black--text" to="/login">Login Member</v-tab>
        <v-tab class="black--text" to="/admin/login_admin">Login Admin</v-tab>
      </v-tabs>
      <v-btn icon @click.stop="drawer = !drawer">
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
      :style="{ backgroundColor: 'white' }"
      class="white">
      <v-list>
        <v-list-item>
          <v-list-item-content class="black--text">
            <v-list-item-title class="headline">เมนูเพิ่มเติม</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
        <v-divider></v-divider>
        <v-list-item link class="black--text">
          <v-list-item-icon><v-icon class="black--text">mdi-account</v-icon></v-list-item-icon>
          <v-list-item-title>โปรไฟล์</v-list-item-title>
        </v-list-item>
        <v-list-item link class="black--text">
          <v-list-item-icon><v-icon class="black--text">mdi-cog</v-icon></v-list-item-icon>
          <v-list-item-title>ตั้งค่า</v-list-item-title>
        </v-list-item>
        <v-list-item link class="black--text">
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
export default {
  data() {
    return {
      drawer: false
    }
  }
}
</script>

<style>
</style>