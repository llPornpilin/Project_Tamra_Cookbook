<template>
    <div>
        <topbarVUE />
        <div class="columns is-max-desktop inside" style="background-color:  var(--cream);">
            <sidemenubarVUE :user="user" />


            <div class="column list-fav-menu">
                <!-- search bar -->
                <div id="searchArea">
                    <input v-model="search" class="input has-text-left" type="text" placeholder="Search Menu ..."
                        id="search" name="search">
                    <!-- <button class="button" id="searchButton" @click.stop="getSearch"><i class="fas fa-search"></i></button> -->
                </div>

                <!-- start form menu  -->
                <table class="table is-fullwidth" id="fav-menu" v-for="(menu, index) in menus"
                    :class="{'has-background-warning-light': select_menu && index === index_menu}"
                    @click.prevent="showMenu(menu.menu_id), select_menu = true, index_menu = index" :key="index">

                    <p>{{ checkSearch }}</p>
                    <!-- select_menu = true,  -->
                    <tr>
                        <td rowspan="4" style="width: 128px">
                            <figure class="image is-128x128" style="border: 5px solid var(--cream-l);">
                                <img :src="menu.menu_image ? 'http://localhost:3000/uploads/' + menu.menu_image : 'https://bulma.io/images/placeholders/640x360.png'"
                                    alt="Placeholder image" style="height: 100%; object-fit:contain;">
                            </figure>
                        </td>
                        <td><b>ชื่อเมนู</b> : {{ menu.menu_name }} </td>
                        <td rowspan="2">
                            <div class="icon is-size-4" @click.stop="fav_function(menu.menu_id)">
                                <!-- star ทึบ -->
                                <span class="icon" key="true" v-if="menu.star_id == user.user_id"  id="favorite_star_0">
                                    <i class="fa-solid fa-star"></i>
                                </span>
                                <!-- star ใส -->
                                <span class="icon" key="false" v-if="menu.star_id != user.user_id"  id="favorite_star_1">
                                    <i class="fa-regular fa-star"></i>
                                </span>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td><b>Nation</b> : {{ menu.nation_name }} Food</td>
                    </tr>
                    <tr>
                        <td><b>Method</b> : {{ menu.cooking_name }}</td>
                    </tr>
                    <tr>
                        <td><b>Meat</b> : {{ menu.meat_name }}</td>
                    </tr>
                </table>
                <!-- end form menu -->
            </div>


            <!-- show-select-fav-menu -->

            <div class="column show-select-fav-menu">
                <!-- select menu false -->
                <p style="justify-content: center; text-align: center; margin-top: 50%" v-if="select_menu == false">
                    Select Your Menu To Show
                </p>
                <!-- select menu true -->
                <div v-if="select_menu == true">
                    <div v-for="(menu, index) in showonemenu" :key="index">
                        <!-- -----------SAVE------------- -->
                        <div>
                            <div class="is-size-4 has-text-centered mt-4 mb-4 ml-3 mr-3"
                                style="background-color: var(--yellow); border-radius:20px; border:5px solid #ffffff; position:sticky; top:0; z-index:5;">
                                <p>{{ menu.menu_name }}</p>
                            </div>
                            <figure class="image is-2by1 ml-6 mr-6 mt-3">
                                <img :src="menu.menu_image ? 'http://localhost:3000/uploads/' + menu.menu_image : 'https://bulma.io/images/placeholders/640x360.png'"
                                    style="object-fit:cover; border-radius:20px; border: 5px solid var(--cream);" />
                            </figure>
                            <!-------------------------- comment-----------------------(start)--------------------------->
                            <!-- icon chat & like -----------------(start) -->
                            <div style="font-size: 20px; float:right ; margin-right:  50px; margin-top: 5px;">
                                <i class="fa-solid fa-comment" @click="show_comment(menu)" id="btnComment"></i>
                                <span @click="addLike(menu.menu_id)" id="btnLike" style="margin-left: 5px;">
                                    <i class="fa-solid fa-thumbs-up"></i>
                                    <!-- <i class="fa-solid fa-thumbs-up" v-if="statusLike == 1"></i>
                                    <i class="fa-regular fa-thumbs-up" v-if="statusLike == 0"></i> -->
                                    <span style="margin-left:5px">{{ menu.menu_id_count
                                    }}</span>
                                    <!-- <i class="fa-solid fa-thumbs-up"></i><span style="margin-left:5px">{{ menu.menu_id_count
                                    }}</span> -->
                                </span>
                            </div>
                            <!-- icon chat & like -----------------(end) -->
                            <div class="modal" :class="{ 'is-active': isActive }">
                                <div class="modal-background"></div>
                                <div class="modal-card">
                                    <header class="modal-card-head">
                                        <p class="modal-card-title">COMMENT</p>
                                        <button class="delete" aria-label="close" @click="closeModal"></button>
                                    </header>
                                    <div style="background-color: #ffffff;">
                                        <div class="comment">
                                            <div v-for="(comment, index) in comment_this_menu" :key="index">
                                                <section class="modal-card-body" v-if="index % 2 == 0" id="commentItem0">
                                                    <div>
                                                        <p style="text-align: left; margin-left: 20px; font-size: 20px;">
                                                            {{ comment.detail }}</p>
                                                        <p
                                                            style="text-align: left; margin-left: 20px; font-size: 15px; color: #a09f9c;">
                                                            {{ comment.username }}
                                                            <span
                                                                style="float: right; margin-right: 10px; font-size: 15px;">{{
                                                                    comment.comment_date }}
                                                                <span>
                                                                    <i v-if="comment.comment_by_id == user.user_id"
                                                                        class="fa fa-minus"
                                                                        style="float: right; font-size: 15px; margin-left: 10px;" id="deleteItem"
                                                                        @click.stop="deleteComment(comment.detail, comment.comment_id, comment.menu_id)"></i>
                                                                </span>
                                                            </span>
                                                        </p>
                                                    </div>
                                                </section>
                                                <section class="modal-card-body" v-if="index % 2 != 0" id="commentItem1">
                                                    <div>
                                                        <p style="text-align: left; margin-left: 20px; font-size: 20px;">
                                                            {{ comment.detail }}</p>
                                                        <p
                                                            style="text-align: left; margin-left: 20px; font-size: 15px; color: #a09f9c;">
                                                            {{ comment.username }}
                                                            <span
                                                                style="float: right; margin-right: 10px; font-size: 15px;">{{
                                                                    comment.comment_date }}
                                                                <span>
                                                                    <i v-if="comment.comment_by_id == user.user_id"
                                                                        class="fa fa-minus"
                                                                        style="float: right; font-size: 15px; margin-left: 10px;" id="deleteItem"
                                                                        @click.stop="deleteComment(comment.detail, comment.comment_id, comment.menu_id)"></i>
                                                                </span>
                                                            </span>
                                                        </p>
                                                    </div>
                                                </section>
                                            </div>
                                        </div>
                                    </div>
                                    <footer class="modal-card-foot">
                                        <input class="input" type="text" style="width: 80%;" v-model="comment"><button
                                            class="button" style="width: 20%" id="btnSubComment"
                                            @click="addComment(menu.menu_id)">submit</button>
                                    </footer>
                                </div>
                            </div>
                            <!----------------------- comment-------------------------(end)----------------------------->
                            <div class="is-size-6 has-text-left ml-5 mr-5 p-1"
                                style="background-color: var(--yellow-l); border-radius:10px; margin-top: 40px;">
                                <p class="ml-5"><b>Nation : </b>{{ menu.nation_name }} Food </p>
                                <p class="ml-5"><b>Method : </b>{{ menu.cooking_name }}</p>
                                <p class="ml-5"><b>Meat : </b>{{ menu.meat_name }} </p>
                            </div>
                            <div class="is-size-6 has-text-left mt-2 ml-5 mr-5 p-1"
                                style="background-color: var(--yellow-l); border-radius:10px;">
                                <p class="ml-5">{{ days }} <b>days</b> : {{ hours }} <b>hour</b> : {{ minutes }}
                                    <b>minutes</b>
                                </p>
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
    </div>
</template>
  
<script>
import topbarVUE from './topBar.vue';
import sidemenubarVUE from './sideMenuBar.vue';
// import axios from "axios";
import axios from '@/plugins/axios' //+

export default {
    components: {
        topbarVUE,
        sidemenubarVUE
    },
    props: ['user'], // รับ Props user มาจาก App.vue
    data() {
        return {
            menus: null, // add blogs variable
            showonemenu: null, // show one menu 
            select_menu: false,
            select_show: false,
            menu_ingredients: '',
            menu_methods: '',
            index_menu: 0,
            days: 0,
            hours: 0,
            minutes: 0,
            //----------edit------------
            e_menu_name: '', //ชื่อเมนูที่กรอก
            e_image: '', //รูปใหม่
            images: [],
            editToggle: -1,
            //-------comment----------------
            isActive: false, // สถานะของ Modal
            comment_this_menu: null,
            comment: "",
            // ----------search----------
            search: "",
            //-----like------
            statusLike: 0,

        };
    },
    created() {
        // console.log('search in AllMenu.vue --------->', search_value)
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
        loadImg(event) {
            console.log("click loadImg")
            this.images = event.target.files;
            console.log("loadImg", this.images)
            console.log("in showSelectImage", this.images[0].name)
            this.e_image = this.images[0].name
        },
        // showSelectImage(images) {
        //     // for preview only
        //     console.log("show", images)
        //     console.log("in showSelectImage", URL.createObjectURL(images))
        //     return URL.createObjectURL(images);
        // },
        // editMenu(index, menu) {
        //     this.editToggle = index
        //     this.e_menu_name = menu.menu_name
        //     this.e_image = menu.menu_image
        // },
        //เมื่อclick เลือกเมนู จะโชว์รายละเอียดเมนู
        showMenu(id) {
            axios.get('http://localhost:3000/showmenu/' + id
            ).then(response => {
                console.log("มาแล้ว-->", response.data)
                this.showonemenu = response.data;
                console.log("showonemenu", this.showonemenu)
                let time = response.data[0].menu_duration
                this.days = Math.floor(time / 1440); // 1 วันมี 1440 นาที
                this.hours = Math.floor((time % 1440) / 60); // 1 ชั่วโมงมี 60 นาที
                this.minutes = time % 60;
                this.menu_ingredients = this.menus[this.index_menu].menu_ingredients.split(",");
                this.menu_methods = this.menus[this.index_menu].menu_methods.split(",");

                console.log(this.days, this.hours, this.minutes)

            })
                //-------------------------------------
                .catch(error => {
                    console.log(error.message);
                });
        },
        getCategories(id) {
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
            axios.get('http://localhost:3000/showmenu/' + id
            ).then(response => {
                console.log("มาแล้ว fucn", response.data)
                this.showonemenu = response.data;
                console.log("func", this.showonemenu)
                console.log(response.data[0].menu_duration)
                let time = response.data[0].menu_duration
                this.days = Math.floor(time / 1440); // 1 วันมี 1440 นาที
                this.hours = Math.floor((time % 1440) / 60); // 1 ชั่วโมงมี 60 นาที
                this.minutes = time % 60;
                this.menu_ingredients = this.menus[this.index_menu].menu_ingredients.split(",");
                this.menu_methods = this.menus[this.index_menu].menu_methods.split(",");
                console.log(this.days, this.hours, this.minutes)

            })
        },
        saveEditMenu(menuId) {
            console.log(menuId, this.e_menu_name, this.images[0])

            let formData = new FormData();
            formData.append("name", this.e_menu_name);
            formData.append("id", menuId);
            if (this.images[0] == null) {
                formData.append("image", "not_change");
            } else {
                formData.append("image", this.images[0]);
            }

            axios.put(`http://localhost:3000/updates`, formData)
                .then((response) => {
                    console.log("then", response.data.data[0])
                    // console.log("then",response.data.data[0])
                    this.editToggle = -1;
                    this.getCategories(response.data.data[0].menu_id);
                    // this.$router.push({ name: 'CategoryMenu' })
                }).catch((error) => {
                    this.error = error.message;
                })
        },
        fav_function(menu_id) {
            console.log(menu_id)
            axios
                .get("http://localhost:3000/check_star/" + menu_id)
                .then((response) => {
                    console.log("เมนูที่เหลือ ", response.data);
                    //
                    axios
                        .get("http://localhost:3000/allmenu/" + this.$route.params.category_type + '/' + this.$route.params.category_id)
                        .then((response) => {
                            this.menus = response.data;
                            console.log("หลังจากกดดาว", this.menus);
                        })
                        .catch((err) => {
                            console.log(err);
                        });

                })
                .catch((err) => {
                    console.log(err);
                });
        },
        show_comment(menu) {
            this.isActive = true; // เปิด Modal

            console.log("show_comment", menu.menu_id)

            axios.get('http://localhost:3000/comment/' + menu.menu_id
            ).then(response => {
                console.log("มาแล้ว", response.data)
                this.comment_this_menu = response.data;
            })
                //-------------------------------------
                .catch(error => {
                    console.log(error.message);
                });
        },
        closeModal() {
            this.isActive = false; // ปิด Modal comment
        },
        addComment(menu_id) {
            console.log("click addComment")
            axios
                .post("http://localhost:3000/addComment", { detail: this.comment, menu_id: menu_id })
                .then(response => {
                    console.log("มาแล้ว", response.data)
                    this.comment_this_menu = response.data
                    this.comment = ""
                })
                .catch((e) => console.log(e.response.data));
            console.log("axios")
        },
        deleteComment(comment, comment_id, menu_id) {
            console.log("comment --> ", comment);
            console.log("comment_id --> ", comment_id);
            const result = confirm(`Are you sure you want to delete this comment`);
            if (result) {
                axios
                    .delete('http://localhost:3000/comment/' + comment_id + "/" + menu_id)
                    .then((response) => {
                        console.log("delete", response.data)
                        this.comment_this_menu = response.data
                    })
                    .catch((error) => {
                        alert(error.response.data.message);
                    });
            }
        },
        addLike(menu_id) {
            console.log("menu_id", menu_id)
            axios
                .post("http://localhost:3000/addLike/" + menu_id)
                .then((response) => {
                    console.log("like ", response.data);
                    this.getCategories(menu_id);
                })
                .catch((err) => {
                    console.log(err);
                });
        },
        // เรียกเมนูที่ search มาแสดง
        getSearch() {
            console.log("Front Search in Allmenu.vue : ", this.search)
            axios.get("http://localhost:3000/allmenu/" + this.$route.params.category_type + '/' + this.$route.params.category_id, {
                params: {
                    search_value: this.search
                }
            })
                .then((response) => {
                    console.log('response.data - AllMenu.vue ', response.data);
                    console.log("length search --------- ", response.data.length)
                    if(response.data.length == 0){
                        this.getSearch()
                    }
                    this.menus = response.data
                })
                .catch((error) => {
                    console.log(error);
                });
        },
        // เรียกเมนูทั้งหมด ถ้าไม่พิมพ์อะไรในช่อง search
        callMenuAgain(){
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
    },
    computed: {
        checkSearch(){
            if (this.search == ''){
                return this.callMenuAgain()
            }
            return this.getSearch()
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

#searchArea{
    width: fit-content;
    height: fit-content;
    border-radius: 30px;
    background-color: white;
}

#search {
    border: none;
    width: 300px;
    border-radius: 15px;
}

#searchButton {
    border: none;
    border-radius: 30px;
    border-top-left-radius: 0px;
    border-bottom-left-radius: 0px;
    position: relative;
    right: 0px;
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