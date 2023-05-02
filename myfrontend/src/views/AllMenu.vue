<template>
    <div>
        <topbarVUE />
        <div class="columns is-max-desktop inside">
            <sidemenubarVUE />


            <div class="column list-fav-menu">

                <!-- start form menu  -->
                <table class="table is-fullwidth" id="fav-menu" v-for="(menu, index) in menus"
                    :class="[{ 'has-background-warning-light': menu.is_favorite }]"
                    @click="showMenu(menu.menu_id), select_menu = true, index_menu = index" :key="index">
                    <!-- select_menu = true,  -->
                    <tr>
                        <td rowspan="4" style="width: 128px">
                            <figure class="image is-128x128" style="border: 5px solid var(--cream-l);">
                                <img :src="menu.menu_image ? 'http://localhost:3000/uploads/'+ menu.menu_image : 'https://bulma.io/images/placeholders/640x360.png'"
                                                alt="Placeholder image"  style="height: 100%; object-fit:contain;">
                            </figure>
                        </td>
                        <td><b>ชื่อเมนู</b> : {{ menu.menu_name }} </td>
                        <td rowspan="2">
                            <div class="icon is-size-4" @click.stop="isFavorite(menu)">
                                <!-- star ทึบ -->
                                <span class="icon" key="true" v-if="menu.is_favorite == true">
                                    <i class="fas fa-star has-text-warning"></i>
                                </span>
                                <!-- star ใส -->
                                <span key="false" v-if="menu.is_favorite == false">
                                    <i class="far fa-star has-text-warning"></i>
                                </span>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td><b>meat</b> : {{ menu.category_meat }}</td>
                    </tr>   
                    <tr>
                        <td><b>category</b> : {{ menu.category_nation }} food</td>
                    </tr>
                    <tr>
                        <td><b>Method</b> : {{ menu.category_cooking }}</td>
                    </tr>

                </table>
                <!-- end form menu -->
            </div>


            <!-- show-select-fav-menu -->

            <div class="column show-select-fav-menu">
                <!-- select menu false -->
                <p style="text-align: center; margin-top: 50%" v-if="select_menu == false">
                    select Select Your Menu To Show
                </p>
                <!-- select menu true -->
                <div v-if="select_menu == true">
                    <div v-for="(menu, index) in showonemenu" :key="index">
                        <div class="is-size-4 has-text-centered mt-4 mb-4 ml-3 mr-3"
                            style="background-color: var(--yellow); border-radius:20px; border:5px solid #ffffff; position:sticky; top:0; z-index:5;">
                            <p>{{ menu.menu_name }}</p>
                        </div>
                        <figure class="image is-2by1 ml-6 mr-6 mt-3">
                            <img :src="menu.menu_image"
                                style="object-fit:cover; border-radius:20px; border: 5px solid var(--cream);" />
                            <!-- <img :src="menu.menu_image ? 'http://localhost/3000'+ menu.menu_image : 'https://bulma.io/images/placeholders/640x360.png'"
                                                alt="Placeholder image"> -->
                            <img :src="menu.menu_image ? 'http://localhost:3000/uploads/'+ menu.menu_image : 'https://bulma.io/images/placeholders/640x360.png'"
                                                alt="Placeholder image" >
                        </figure>
                        <div class="is-size-6 has-text-left mt-5 ml-5 mr-5 p-1"
                            style="background-color: var(--yellow-l); border-radius:10px;">
                            <p class="ml-5"><b>Nation : </b>{{ menu.category_nation }} food </p>
                            <p class="ml-5"><b>Method :</b>{{ menu.category_cooking }}</p>
                            <p class="ml-5"><b>Meat :</b>{{ menu.category_meat }} </p>
                        </div>
                        <div class="is-size-6 has-text-left mt-2 ml-5 mr-5 p-1"
                            style="background-color: var(--yellow-l); border-radius:10px;">
                            <p class="ml-5">{{ days }} <b>days</b> : {{ hours }} <b>hour</b> : {{ minutes }} <b>minutes</b></p>
                        </div>
                        <!-- วัตถุดิบ -->
                        <div class="has-text-left m-1 mt-4"
                            style="border-radius: 20px; border: 3px solid #00000000; background: var(--cream-l)">
                            <p class="is-size-5 m-3 ml-4" style="color:var(--black)"><b>วัตถุดิบ</b></p>
                            <ol class="ml-6 mb-3 mr-6">
                                <li v-for="(item, index) in menu_ingredients" :key="index">{{ item }}</li>
                            </ol>
                        </div>
                        <!-- วิธีทำ -->
                        <div class="has-text-left m-1 mt-5"
                            style="border-radius: 20px; border: 3px solid #00000000; background: var(--cream-l)">
                            <p class="is-size-5 m-3 ml-4"><b>วิธีทำ</b></p>
                            <ol class="ml-6 mb-3 mr-6">
                                <li v-for="(item, index) in menu_methods" :key="index">{{ item }}</li>
                            </ol>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
  
<script>
import topbarVUE from './topBar.vue';
import sidemenubarVUE from './sideMenuBar.vue';
import axios from "axios";
export default {
    components: {
        topbarVUE,
        sidemenubarVUE
    },
    data() {
        return {
            menus: null, // add blogs variable
            showonemenu: null, // show one menu 
            select_menu: false,
            select_show: false,
            index_menu: 0,
            days:0,
            hours:0,
            minutes:0,
        };
    },
    created() {
        // console.log(this.$route.params.category_type)
        // console.log(this.$route.params.category_id)
        axios
            .get("http://localhost:3000/allmenu/" + this.$route.params.category_type + '/' + this.$route.params.category_id)
            .then((response) => {
                this.menus = response.data;
                console.log(this.menus);
                console.log(response.data)
            })
            .catch((err) => {
                console.log(err);
            });
    },
    methods: {
        //เมื่อclick เลือกเมนู จะโชว์รายละเอียดเมนู
        showMenu(id) {
            axios.get('http://localhost:3000/showmenu/' + id
            ).then(response => {
                console.log("มาแล้ว", response.data)
                this.showonemenu = response.data;
                let time = response.data[0].menu_duration
                // console.log(response.data[0].menu_duration)
                this.days = Math.floor(time / 1440); // 1 วันมี 1440 นาที
                this.hours = Math.floor((time % 1440) / 60); // 1 ชั่วโมงมี 60 นาที
                this.minutes = time % 60;
                console.log(this.days, this.hours, this.minutes)

            })
                //-------------------------------------
                .catch(error => {
                    console.log(error.message);
                });
        }
    },
    computed: {
        menu_ingredients() {
            console.log(this.menus[this.index_menu].menu_ingredients.split(","))
            return this.menus[this.index_menu].menu_ingredients.split(",");
        },
        menu_methods() {
            console.log(this.menus[this.index_menu].menu_methods.split(","))
            return this.menus[this.index_menu].menu_methods.split(",");
        }
    }
};
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
    position: absolute;
    right: 50px;
    top: 18px;
    background-color: var(--cream);
}

/* middle page ----------------------------------------- */
.list-fav-menu {
    background-color: var(--yellow);
    border-radius: 30px;
    height: var(--height1);
    overflow-y: scroll;
}

/* i_star-------------------- */
#i_star_1,
#i_star_2,
#i_star_3,
#i_star_4,
#i_star_5,
#i_star_6 {
    color: gainsboro;
    font-size: 20px;
}

/* scrollbar----------------- */
/* width */
.list-fav-menu::-webkit-scrollbar {
    width: 20px;
}

/* Track */
.list-fav-menu::-webkit-scrollbar-track {
    margin-top: 40px;
    margin-bottom: 40px;
    border-radius: 100px;
}

/* Handle */
.list-fav-menu::-webkit-scrollbar-thumb {
    background: var(--cream);
    border-radius: 100px;
    border: 5px solid transparent;
    background-clip: content-box;
}

/* table column---------------- */
#fav-menu {
    background-color: #fff;
    margin-left: 5px;
    margin-right: -5px;
    margin-top: 10px;
    border-radius: 10px;
}

#icon_pen {
    color: var(--lightgreen);
    border-radius: 10px;
    background: var(--cream);
}

#icon_pen:hover {
    color: var(--yellow);
}

#icon_trash {
    color: var(--lightgreen);
    margin-left: 10px;
}

#icon_trash:hover {
    color: var(--yellow);
}


/* back page ----------------------------------------- */
.show-select-fav-menu {
    background-color: var(--white);
    border-radius: 30px;
    height: var(--height1);
    overflow-y: scroll;

}

/* scrollbar----------------- */
/* width */
.show-select-fav-menu::-webkit-scrollbar {
    width: 20px;
}

/* Track */
.show-select-fav-menu::-webkit-scrollbar-track {
    margin-top: 40px;
    margin-bottom: 40px;
    border-radius: 100px;
}

/* Handle */
.show-select-fav-menu::-webkit-scrollbar-thumb {
    background: var(--yellow);
    border-radius: 100px;
    border: 5px solid transparent;
    background-clip: content-box;
}


/* edit-menu */
#menuIngrediant,
#menuMethod,
#showIngrediant,
#showMethod {
    resize: none;
    overflow-y: scroll;
    border-radius: 20px;
    border: 2px solid var(--yellow);
}

#menuName {
    border-radius: 20px;
    border: 2px solid var(--yellow);
}

#imageBox {
    width: 90%;
    height: 45%;
    background-repeat: no-repeat;
    background-size: cover;
    background-color: var(--cream);
    border-radius: 30px;
    border-style: dashed;
    border-color: var(--yellow);
}

select {
    width: 100%;
    margin-top: 10px;
    border-radius: 20px;
    background-color: var(--darkgreen);
    color: #f4eea9;
    height: 35px;
    padding-left: 20px;
}

/* ------spending time--------- */
#day,
#hour,
#minute {
    background-color: var(--cream);
    border: 2.5px solid var(--darkgreen);
}

#addMenuButton {
    background-color: var(--yellow);
    border: 2.5px solid var(--darkgreen);
    margin-top: 30px;
    width: 200px;
    position: relative;
    /* top: 0; */
    left: 38%;
}

.textarea::-webkit-scrollbar {
    width: 15px;
}

/* Track */
.textarea::-webkit-scrollbar-track {
    margin-top: 20px;
    margin-bottom: 20px;
}

/* Handle */
.textarea::-webkit-scrollbar-thumb {
    background: var(--yellow);
    border-radius: 10px;
}
</style>