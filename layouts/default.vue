<template>
  <v-app>
    <v-app-bar class="white" app>
      <v-tabs background-color="white">
        <v-tab class="black--text" to="/">Dewgasohol</v-tab>
        <v-tab class="black--text" to="/home">Home</v-tab>
        <v-tab class="black--text" to="/about">About</v-tab>
        <v-tab class="black--text" to="/news">News</v-tab>
        <v-tab class="black--text" to="/contact">Contact</v-tab>
        <v-tab class="black--text" to="/forms">Forms</v-tab>
        <v-spacer></v-spacer>
        <v-tab class="black--text" to="/test">Test</v-tab>
      </v-tabs>
    </v-app-bar>
    <v-main>
      <nuxt />
    </v-main>
  </v-app>
</template>

<script>
export default {
  // ...existing code...
}
</script>

<style>
/* ...existing code... */
</style>