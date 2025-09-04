<template>
  <v-app style="height: auto; margin: 0 auto;">   
    <v-app-bar style=" height: auto; margin: auto;" app>
      <v-toolbar-title class="black--text" style="font-weight: bold; font-size: 20px; flex-grow: 1; white-space: normal; overflow: visible; text-overflow: unset; display: flex; align-items: center;">
        <div class="tenor-gif-embed" data-postid="3210703131552940069" data-share-method="host" data-aspect-ratio="0.894309" data-width="40px" style="margin-right: 12px; display: inline-block; vertical-align: middle;"><a href="https://tenor.com/view/ina-memes-smirk-shrek-gif-3210703131552940069">Ina Memes Smirk GIF</a>from <a href="https://tenor.com/search/ina+memes-gifs">Ina Memes GIFs</a></div>
        <span style="font-weight:bold; font-size:20px; min-width:140px;">DEWGASOHOL **BETA**</span>
      </v-toolbar-title>
      <script type="text/javascript" async src="https://tenor.com/embed.js"></script>
      <v-tabs tabs slider-color="black">
        <!-- <v-tab class="black--text" disabled style="font-weight:bold; font-size:20px; min-width:140px;">DEWGASOHOL</v-tab> -->
        <v-tab class="black--text" to="/home">Home</v-tab>
        <v-tab class="black--text" to="/news">News</v-tab>
        <v-tab class="black--text" to="/contact">Contact</v-tab>
        <v-tab class="black--text" to="/forms">Forms</v-tab>
          <v-menu offset-y transition="scroll-y-transition">
            <template v-slot:activator="{ on, attrs }">
              <v-btn
                text
                class="black--text"
                v-bind="attrs"
                v-on="on"
                style="padding: 16px; display: flex; align-items: center; justify-content: center; min-width: 100px; font-size: 14px; height: auto;"
              >
                More
                <v-icon small style="margin-left:8px;">mdi-menu-down</v-icon>
              </v-btn>
            </template>
            <v-list>
              <v-list-item link to="/arsenal-data/stations">
                <v-list-item-title>Stations</v-list-item-title>
              </v-list-item>
              <v-list-item link to="/arsenal-data/users">
                <v-list-item-title>Users</v-list-item-title>
              </v-list-item>
            </v-list>
          </v-menu>
        <v-spacer></v-spacer>
        <!-- <v-tab class="black--text" to="/test">Test PAGE</v-tab> -->
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
          <v-list-item-avatar>
            <v-img src="/This is number 357.jpg"></v-img>
          </v-list-item-avatar>
          <v-list-item-content class="black--text">
            <v-list-item-title class="headline">เปิ้ลนาคร</v-list-item-title>
            <v-list-item-subtitle>triggerbutbossfirst@outlook.com</v-list-item-subtitle>
          </v-list-item-content>
        </v-list-item>
        <v-divider></v-divider>
        <v-list-item link class="black--text" to="/member/profile">
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