<template>
    <!------------------------ side menu bar --------------------------------->
    <aside class="column is-one-fifth has-background-white pl-6 pr-6">
        <figure class="image mr-auto ml-auto pt-5">
            <img src="/img/chef_hat.png" class="mr-auto ml-auto mt-5" style="width: 170px; margin-bottom: 50px;">
        </figure>
        <div style="padding-bottom: 50px;" >
            <p style="font-weight:900">User: {{ this.user.username }}</p>
            <p style="font-weight:500; color: #888888; font-size: 10px;">(Email: {{ this.user.email }})</p>
        </div>
        <div class="menu">
            <ul class="menu-list">
                <!-- <li class="menu-item has-text-centered mb-5 ml-6" style="background-color: #f4eea9; width: 110%;">
                    <a href="/home" style="color: #064635;"><b>Home</b></a>
                </li> -->
                <li class="menu-item has-text-centered mb-5" :class="{ 'home-menu': $route.name === 'HomePage' }">
                    <a href="/" style="color: #f4eea9;" onMouseOver="this.style.color = '#064635'"
                        onmouseout="this.style.color = '#f4eea9'" :class="{ 'home-text': $route.name === 'HomePage' }"><b>Home </b></a>
                </li>
                <li class="menu-item has-text-centered mb-5" :class="{ 'allmenu-menu': $route.name === 'AllMenu' }">
                    <a href="/allmenu" style="color: #f4eea9;" onMouseOver="this.style.color = '#064635'"
                        onmouseout="this.style.color = '#f4eea9'" :class="{ 'allmenu-text': $route.name === 'AllMenu' }"><b>All Menu</b></a>
                </li>
                <li class="menu-item has-text-centered mb-5" :class="{ 'addmenu-menu': $route.name === 'addmenu' }">
                    <a href="/addmenu" style="color: #f4eea9;" onMouseOver="this.style.color = '#064635'"
                        onmouseout="this.style.color = '#f4eea9'" :class="{ 'addmenu-text': $route.name === 'addmenu' }"><b>Add My Menu</b></a>
                </li>
                <li class="menu-item has-text-centered mb-5" :class="{ 'favorite-menu': $route.name === 'favorite' }">
                    <a href="/favorite" style="color: #f4eea9;" onMouseOver="this.style.color = '#064635'"
                        onmouseout="this.style.color = '#f4eea9'" :class="{ 'favorite-text': $route.name === 'favorite' }"><b>Favorite</b></a>
                </li>
                <li class="menu-item has-text-centered mb-5" :class="{ 'mymenu-menu': $route.name === 'mymenu' }">
                    <a href="/mymenu" style="color: #f4eea9;" onMouseOver="this.style.color = '#064635'"
                        onmouseout="this.style.color = '#f4eea9'" :class="{ 'mymenu-text': $route.name === 'mymenu' }"><b>My Menu</b></a>
                </li><br>
                <li class="menu-item has-text-centered mt-6" @click="logOut()">
                    <a style="color: #f4eea9;" onMouseOver="this.style.color = '#064635'"
                        onmouseout="this.style.color = '#f4eea9'"><b>Log out</b></a>
                </li>
            </ul>
        </div>
    </aside>
</template>

<script>
// import axios from '@/plugins/axios' //+

export default ({
    props: ['user'], // รับ Props user มาจาก App.vue
    methods: {
        logOut() {
            localStorage.removeItem('token');
            this.$router.push({ name: 'signin' })
        }
    },
})

</script>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Lobster+Two:ital@1&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Lobster+Two:ital@1&family=Montserrat+Alternates&display=swap');

#top {
    background-color: var(--yellow);
}

.inside {
    margin: 0px;
    box-sizing: border-box;
    padding: 40px;
}

/* side menu bar */
aside {
    box-shadow: none;
    margin-right: 40px;
    border-radius: 30px;
    padding: 50px;
    overflow: hidden;
}

.menu-item {
    background-color: var(--darkgreen);
    border-radius: 70px;
}

.menu-item:hover {
    background-color: var(--cream);
    transform: translateX(15px);
}

.menu-item a:hover {
    background-color: var(--cream);
    border-radius: 70px;
}

.home-menu {
    background-color: var(--cream) !important;
    border: 3px solid var(--darkgreen);
    width: 150%;
  }
  
.home-text {
color: var(--darkgreen) !important;
}

.allmenu-menu {
    background-color: var(--cream) !important;
    border: 3px solid var(--darkgreen);
    width: 150%;
  }
  
.allmenu-text {
color: var(--darkgreen) !important;
}
.addmenu-menu {
    background-color: var(--cream) !important;
    border: 3px solid var(--darkgreen);
    width: 150%;
  }
  
.addmenu-text {
color: var(--darkgreen) !important;
}

.favorite-menu {
    background-color: var(--cream) !important;
    border: 3px solid var(--darkgreen);
    width: 150%;
  }
  
.favorite-text {
color: var(--darkgreen) !important;
}
.mymenu-menu {
    background-color: var(--cream) !important;
    border: 3px solid var(--darkgreen);
    width: 150%;
  }
  
.mymenu-text {
color: var(--darkgreen) !important;
}



</style>