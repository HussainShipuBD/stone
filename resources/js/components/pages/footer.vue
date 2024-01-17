<template>
  <div
    class="_footer"
    v-if="
      $route.path != '/register' &&
      $route.path != '/accountVerified' &&
      $route.path != '/sendAgain'
    "
  >
    <div class="container">
      <ul class="_footer_list">
        <li>
          <router-link to="/aboutUs">About us</router-link>
        </li>
        <li>
          <router-link to="/privecy">Privecy & Policy</router-link>
        </li>
        <li>
          <a href="https://www.facebook.com/Pathorerjogoth/" target="_blank">
            <Icon type="logo-facebook"
          /></a>
        </li>
        <li>
          <a href="https://www.instagram.com/Pathorerjogoth" target="_blank">
            <Icon type="logo-instagram"
          /></a>
        </li>
      </ul>
    </div>
  </div>
</template>