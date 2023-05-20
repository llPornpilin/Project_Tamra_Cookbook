<template>
    <!-- <div style="background-color:  var(--cream);"> -->
        <div>

        <topbarVUE />
        <div class="columns is-max-desktop inside" style="background-color:  var(--cream);">
            <sidemenubarVUE :user="user"/>
            <!---------------------------------------------- category ------------------------------------------------->
            <div class="column is-9 p-0" id="cate">

                <!------------------------------- category nation --------------------------------------->
                <div class="column is-12 has-background-white p-5 category" id="nation">
                    <!-- food -->
                    <div class="card pt-5 pr-2 pl-2 mr-5 cate-type-1 nation" id="cate1"
                        v-for="(nation, index) in category[0]" :key="index"
                        @click="$router.push({ name: 'CategoryMenu', params: { category_id: nation.nation_id, category_type: 'category_nation' } })">
                        <div class="card-img pl-4 pr-4">
                            <figure class="image is-96x96 mr-auto ml-auto">
                                <img class="food_img" :src="nation.nation_image" alt="Placeholder image">
                            </figure>
                        </div>
                        <!-- flag -->
                        <figure class="image is-32x32 mr-auto ml-auto pt-4">
                            <img class="flag" :src="nation.nation_flag" alt="Placeholder image">
                        </figure>
                        <div class="card-content pr-0 pl-0 pb-4 pr-0 pl-0 pb-4">
                            <div class="title is-size-5 has-text-centered">{{ nation.nation_name }} <br>food</div>
                        </div>
                    </div>
                </div>

                <!------------------------------- category type cooking --------------------------------------->

                <div class="column is-12 p-5 category mt-4" id="typeCooking">
                    <!-- each type -->
                    <div class="card pt-5 mr-5 type" v-for="(typecook, index) in category[1]" :key="index"
                        @click="$router.push({ name: 'CategoryMenu', params: { category_id: typecook.cooking_id, category_type: 'category_cooking' } })">
                        <div class="card-img pl-5 pr-5">
                            <figure class="image is-128x128 mr-auto ml-auto">
                                <img class="is-rounded type-img" :src="typecook.cooking_image" alt="Placeholder image">
                            </figure>
                            <div class="title is-size-5 has-text-centered mb-6">{{ typecook.cooking_name }}</div>
                            <div class="subtitle has-text-centered mb-5"></div>
                        </div>
                    </div>

                    <!-- <div class="column is-12 has-background-white" id="line"></div> -->
                </div>

                <!------------------------------- category type meat --------------------------------------->

                <div class="column is-12 p-5 category " id="typeMeat">
                    <!-- each type -->
                    <div class="card pt-5 mr-5 type" v-for="(typemeat, index) in category[2]" :key="index"
                        @click="$router.push({ name: 'CategoryMenu', params: { category_id: typemeat.meat_id, category_type: 'category_meat' } })">
                        <div class="card-img pl-5 pr-5">
                            <figure class="image is-128x128 mr-auto ml-auto">
                                <img class="is-rounded type-img" :src="typemeat.meat_image" alt="Placeholder image">
                            </figure>
                            <div class="title is-size-5 has-text-centered mb-6">{{ typemeat.meat_name }}</div>
                            <div class="subtitle has-text-centered mb-5"></div>
                        </div>
                    </div>

                    <!-- <div class="column is-12 has-background-white" id="line"></div> -->
                </div>
            </div>
        </div>
    </div>
</template>


<script>
import topbarVUE from './topBar.vue';
import sidemenubarVUE from './sideMenuBar.vue';
import axios from '@/plugins/axios' //+  axios interceptor
export default {
    name: "HomePage",
    props: ['user'], // รับ Props user มาจาก App.vue
    components: {
        topbarVUE,
        sidemenubarVUE
    },
    data() {
        return {
            category: null,
        };
    },
    created() {
        console.log("start")
        axios
            .get("http://localhost:3000/")
            .then((response) => {
                this.category = response.data;
                console.log(this.category);
            })
            .catch((err) => {
                console.log(err);
            });

    },

};
</script>

  
<style scoped>
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

#search {
    width: 20%;
    border-radius: 15px;
    position: absolute;
    right: 50px;
    top: 18px;
}

#searchButton {
    border: none;
    border-radius: 15px;
    border-top-left-radius: 0px;
    border-bottom-left-radius: 0px;
    position: absolute;
    right: 50px;
    top: 18px;
    background-color: var(--cream);
}


/* category book-------------------------------------------------- */
#nation {
    box-shadow: none;
    /* border: 40px solid var(--cream); */
    border-radius: 30px;
    height: fit-content;
    display: flex;
    overflow-x: scroll;
    min-width: 30px;
    position: relative;
}

.cate-type-1 {
    height: 250px;
    border-radius: 10px;
    background-color: var(--darkgreen);
}

.cate-type-2 {
    height: 250px;
    border-radius: 10px;
    background-color: var(--lightgreen);
}

.cate-type-1 .title {
    color: var(--cream);
}

.cate-type-2 .title {
    color: var(--darkgreen);
}

/* .category .food_img{
    width: 100%;
    height: 100%;
} */
.nation .flag {
    width: 33px;
    height: 22px;
}

.nation:hover {
    background-color: #f5a55a;
}

/* type cooking------------------------------------------------------ */

/* type cooking box */
#typeCooking,
#typeMeat {
    height: fit-content;
    display: flex;
    overflow-x: scroll;
    position: relative;
    border-top-right-radius: 70px;
    border-top-left-radius: 70px;
}

#typeCooking .card:hover {
    background-color: var(--yellow);
}

#typeMeat .card:hover {
    background-color: var(--yellow);
}

/* each type */
.type {
    background-color: #f6f6f6;
    width: 40rem;
    left: 20px;
}

/* each type image */
.type-img {
    margin-top: 30px;
    transform: translateY(-70px);
}

.type .title {
    color: var(--darkgreen);
}

#line {
    border-radius: 15px;
    top: 90%;
}

/*------- scroll bar -------*/

.category::-webkit-scrollbar {
    width: 15px;
}

/* Track */
.category::-webkit-scrollbar-track {
    margin-left: 20px;
    margin-right: 20px;
    margin-bottom: 20px;
}

/* Handle */
.category::-webkit-scrollbar-thumb {
    background: var(--yellow);
    border-radius: 10px;
}</style>