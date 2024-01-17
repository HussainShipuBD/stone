import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

const store = new Vuex.Store({
  state: {
    authUser: false,
    catStore: [],
    storeAddCard: [],
    sidebar: false
  },
  getters: {
    getIsLoggedIn(state) {
      return !!state.authUser
    },

    getAuthUser(state) {
      return state.authUser
    },

    getAddCard(state) {
      return state.storeAddCard
    },

    getCat(state) {
      return state.catStore
    },

    getSidebar(state) {
      return state.sidebar
    }
  },

  mutations: {
    setAuthUser(state, data) {
      state.authUser = data
    },

    setAddCard(state, data) {
      state.storeAddCard = data
    },

    changeTopic(state, data) {
      state.catStore = data
    },

    setSidebar(state, data) {
      state.sidebar = data
    }
  }
})

export default store;