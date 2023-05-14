<template>
    <!-- top bar -->
    <section class="hero is-small" id="top">
        <div class="hero-body is-flex">
            <div class="container">
                <h6 class="title is-size-4 has-text-centered has-text-weight-bold">
                    <b>Tamra Cookbook</b>
                </h6>
            </div>
            <!-- <form action=""> -->
            <input v-model="search" class="input" type="text" placeholder="Search Menu ..." id="search" name="search">
            <button class="button" id="searchButton" @click="getMenus"><i class="fas fa-search"></i></button>
            <!-- </form> -->
        </div>
    </section>
</template>


<script>
import axios from '@/plugins/axios'
export default {
    data() {
        return {
            search: "",
            menus: [],
        };
    },
    mounted() {
        this.getMenus();
    },
    methods: {
        getMenus() {
        console.log("Front Search : ", this.search)
        axios
        .get("http://localhost:3000/search_menu", {
        params: {
            search: this.search,
        },
        })
        .then((response) => {
        this.menus = response.data;
        console.log(response.data)
        })
        .catch((err) => {
        console.log(err);
        });
    }}
}
</script>


<style scoped>

@import url('https://fonts.googleapis.com/css2?family=Lobster+Two:ital@1&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Lobster+Two:ital@1&family=Montserrat+Alternates&display=swap');

#top{
    background-color: var(--yellow);
}
.inside{
    margin: 0px; 
    box-sizing: border-box;
    padding: 40px;
}
#search{
    width: 250px;
}
</style>