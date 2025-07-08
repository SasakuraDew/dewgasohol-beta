<template>
  <v-tabs
    tabs
    background-color="white"
    color="white"
    slider-color="black"
  >
    <v-tab class="black--text">
      <nuxt-link class="white-btn" to="/"><v-btn>Dewgasohol</v-btn></nuxt-link>
    </v-tab>
    <v-tab class="black--text">
      <nuxt-link class="black--text" to="/home">Home</nuxt-link>
    </v-tab>
    <v-tab class="black--text">
      <nuxt-link class="black--text" to="/about">About</nuxt-link>
    </v-tab>
    <v-tab class="black--text">
      <nuxt-link class="black--text" to="/news">News</nuxt-link>
    </v-tab>
    
  </v-tabs>
</template>