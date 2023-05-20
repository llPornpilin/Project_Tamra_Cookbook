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
                <li class="menu-item has-text-centered mb-5">
                    <a href="/" style="color: #f4eea9;" onMouseOver="this.style.color = '#064635'"
                        onmouseout="this.style.color = '#f4eea9'"><b>Home </b></a>
                </li>
                <li class="menu-item has-text-centered mb-5">
                    <a href="/allmenu" style="color: #f4eea9;" onMouseOver="this.style.color = '#064635'"
                        onmouseout="this.style.color = '#f4eea9'"><b>All Menu</b></a>
                </li>
                <li class="menu-item has-text-centered mb-5">
                    <a href="/addmenu" style="color: #f4eea9;" onMouseOver="this.style.color = '#064635'"
                        onmouseout="this.style.color = '#f4eea9'"><b>Add My Menu</b></a>
                </li>
                <li class="menu-item has-text-centered mb-5">
                    <a href="/favorite" style="color: #f4eea9;" onMouseOver="this.style.color = '#064635'"
                        onmouseout="this.style.color = '#f4eea9'"><b>Favorite</b></a>
                </li>
                <li class="menu-item has-text-centered mb-5">
                    <a href="/mymenu" style="color: #f4eea9;" onMouseOver="this.style.color = '#064635'"
                        onmouseout="this.style.color = '#f4eea9'"><b>My Menu</b></a>
                </li><br>
                <li class="menu-item has-text-centered mt-6" @click="logOut()">
                    <!-- <a href="/user/signin" style="color: #f4eea9;" onMouseOver="this.style.color = '#064635'"
                        onmouseout="this.style.color = '#f4eea9'"><b>Log out</b></a> -->
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
}</style>