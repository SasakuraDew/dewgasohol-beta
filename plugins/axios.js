import Vue from 'vue';
import axios from 'axios';
import VueAxios from 'vue-axios';
Vue.config.productionTip = false;
const request = axios.create({
  baseURL: //'http://127.0.0.1/library_sheet_one/book_select.php'
    'http://localhost/library_sheet_one/book_select.php'
});
Vue.use(VueAxios, request);