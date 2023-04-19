<template>
    <!-- <div id="app">
        <div>{{ menus }}</div>

        <div v-for="(menu,index) in menus" :key="index">
        hi {{ menu.menu_name }}
        </div>
    </div> -->

<!---------------------------------------------- category ------------------------------------------------->
    <body id="app">
        <div class="column is-9 p-0" id="cate">

            <!------------------------------- category nation --------------------------------------->
            <div class="column is-12 has-background-white p-5 category" id="nation">
                <!-- food -->
                <div class="card pt-5 pr-2 pl-2 mr-5 cate-type-1 nation" id="cate1" v-for="(nation, index) in nations" :key="index" @click="nextPage(nation.name)">
                    <div class="card-img pl-4 pr-4">
                        <figure class="image is-96x96 mr-auto ml-auto">
                            <img class="food_img" :src="nation.image" alt="Placeholder image">
                        </figure>
                    </div>
                    <!-- flag -->
                    <figure class="image is-32x32 mr-auto ml-auto pt-4">
                        <img class="flag" :src="nation.flag" alt="Placeholder image">
                    </figure>
                    <div class="card-content pr-0 pl-0 pb-4 pr-0 pl-0 pb-4">
                        <div class="title is-size-5 has-text-centered" >{{nation.name}} <br>food</div>
                    </div>
                </div>
            </div>
                
            <!------------------------------- category type cooking --------------------------------------->
                
            <div class="column is-12 p-5 category mt-4" id="typeCooking">
                <!-- each type -->
                <div class="card pt-5 mr-5 type" v-for="(typecook, index) in typecooks" :key="index" @click="nextPage(typecook.name)"> 
                    <div class="card-img pl-5 pr-5">
                        <figure class="image is-128x128 mr-auto ml-auto">
                            <img class="is-rounded type-img" :src="typecook.image" alt="Placeholder image">
                        </figure>
                        <div class="title is-size-5 has-text-centered mb-6">{{typecook.name}}</div>
                        <div class="subtitle has-text-centered mb-5"></div>
                    </div>
                </div>

                <!-- <div class="column is-12 has-background-white" id="line"></div> -->
            </div>

            <!------------------------------- category type meat --------------------------------------->

            <div class="column is-12 p-5 category " id="typeMeat">
                <!-- each type -->
                <div class="card pt-5 mr-5 type" v-for="(typemeat, index) in typemeats" :key="index" @click="nextPage(typemeat.name)">
                    <div class="card-img pl-5 pr-5">
                        <figure class="image is-128x128 mr-auto ml-auto">
                            <img class="is-rounded type-img" :src="typemeat.image" alt="Placeholder image">
                        </figure>
                        <div class="title is-size-5 has-text-centered mb-6">{{typemeat.name}}</div>
                        <div class="subtitle has-text-centered mb-5"></div>
                    </div>
                </div>

                <!-- <div class="column is-12 has-background-white" id="line"></div> -->
            </div>
        </div>
    </body>
</template>


<script>
// import topBarVUE from './topBar.vue';
import axios from "axios";
export default {
    // components: {
    //     topBarVUE
    // },
    data() {
        return {
            menus: null, // add menu variable
        };
    },
    created() {
        console.log("start")
        axios
            .get("http://localhost:8080/")
            .then((response) => {
                this.menus = response.data;
                console.log(this.menus);
            })
            .catch((err) => {
                console.log(err);
            });
    },
    methods: {
    }
};
</script>

  
<style scoped>
</style>