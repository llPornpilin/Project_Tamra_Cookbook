<template>
    <div>
        <topbarVUE />
        <div class="columns is-max-desktop inside" id="list_menu">
            <sidemenubarVUE :user="user" />

            <!---------------------------------------------- category ------------------------------------------------->

            <div class="column list-fav-menu">
                <!-- search bar -->
                <div id="searchArea">
                    <input v-model="search" class="input has-text-left" type="text" placeholder="Search Menu ..."
                        id="search" name="search">
                    <!-- <button class="button" id="searchButton" @click.stop="getSearch"><i class="fas fa-search"></i></button> -->
                </div>

                <!-- start form menu  -->
                <table class="table is-fullwidth" id="fav-menu" v-for="(menu, index) in menus" :key="index"
                    :class="{'has-background-warning-light': select_menu && index === index_menu}"
                    @click="showMenu(menu.menu_id), select_menu = true, index_menu = index">

                    <p>{{ checkSearch }}</p>
                    <!-- @click="select_menu = true, index_menu = index" -->
                    <tr>
                        <td rowspan="4" style="width: 128px">
                            <figure class="image is-128x128" style="border: 5px solid var(--cream-l);">
                                <img :src="menu.menu_image ? 'http://localhost:3000/uploads/' + menu.menu_image : 'https://bulma.io/images/placeholders/640x360.png'"
                                    alt="Placeholder image" style="height: 100%; object-fit:contain;">
                            </figure>
                        </td>
                        <td><b>ชื่อเมนู</b> : {{ menu.menu_name }} </td>
                        <td rowspan="2">
                            <div class="icon is-size-4"> <!-- @click.stop="menu.is_favorite = !menu.is_favorite" -->
                                <!-- ถังขยะ (กดแล้ว) -->
                                <span key="false" id="icon_trash" @click.stop="deleteMenu(menu.menu_id)">
                                    <i class="fa fa-trash"></i>
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
                <p style="text-align: center; margin-top: 50%" v-if="select_menu == false">
                    Select Your Menu To Show
                </p>
                <!-- select menu true -->

                <div v-for="(menu, index) in showonemenu" :key="index">
                    <!-- แสดงรายละเอียดเมนูเมื่อคลิกเลือก -->
                    <div v-if="select_menu == true">
                        <div v-if="index_menu === editToggle">
                            <div class="content">
                                <input class="input" type="text" id="menuName" v-model="$v.edit_name.$model"
                                :class="{'is-danger': $v.edit_name.$error}">
                                <template v-if="$v.edit_name.$error">
                                    <p class="help is-danger" v-if="!$v.edit_name.minLength" style="text-align: left">This field is required</p>
                                </template>
                                <!-- edit image -->
                                <label class="image is-2by1 container p-6" for="file" id="imageBox">
                                    <img :src="(edit_image == menu.menu_image) ? 'http://localhost:3000/uploads/' + edit_image : showSelectImage(images[0])"
                                        style="object-fit:cover; border-radius:20px; border: 5px solid var(--cream);" />
                                    <input type="file" accept="image/*" name="images" id="file" @change="loadImg"
                                        style="display: none;">
                                </label>
                                <!-- edit category -->
                                <div class="p-5">
                                    <div class="mt-3 is-flex">
                                        <label class="label">Menu Nation</label>
                                        <select v-model="select_nation" name="menuCategory">
                                            <option v-for="(nation, index) in category_nation" :key="index"
                                                :value="nation.nation_id">{{
                                                    nation.nation_name }}
                                            </option>
                                        </select>
                                    </div><br>
                                    <div class="mt-3 is-flex">
                                        <label class="label">Type Cooking</label>
                                        <select v-model="select_cooking" name="menuTypeCook">
                                            <option v-for="(typecook, index) in category_cooking" :key="index"
                                                :value="typecook.cooking_id">{{ typecook.cooking_name
                                                }}</option>
                                        </select>
                                    </div><br>
                                    <div class="mt-3 is-flex">
                                        <label class="label">Type Meat</label>
                                        <select v-model="select_meat" name="menuTypeMeat">
                                            <option v-for="(typemeat, index) in category_meat" :key="index"
                                                :value="typemeat.meat_id">
                                                {{ typemeat.meat_name }}
                                            </option>
                                        </select>
                                    </div>
                                </div>

                                <!-- edit spending time -->
                                <div class="is-flex mt-5" id="spendTime">
                                    <div class="container mr-4 ml-6">
                                        <input class="input has-text-centered" type="number" id="day"
                                        v-model="$v.days.$model" :class="{'is-danger': $v.days.$error}" name="menuDay">
                                        <label class="label is-size-6 has-text-centered" style="color: #064635">Days</label>
                                        <template v-if="$v.days.$error">
                                            <p class="help is-danger" v-if="!$v.days.greaterThanZero" style="text-align: left">must greater than zero</p>
                                        </template>
                                    </div>
                                    <div class="container mr-4 ml-4">
                                        <input class="input has-text-centered" type="number" id="hour"
                                        v-model="$v.hours.$model" :class="{'is-danger': $v.hours.$error}" name="menuHour">
                                        <label class="label is-size-6 has-text-centered" style="color: #064635">Hours</label>
                                        <template v-if="$v.days.$error">
                                            <p class="help is-danger" v-if="!$v.days.greaterThanZero" style="text-align: left">must greater than zero</p>
                                        </template>
                                    </div>
                                    <div class="container ml-4 mr-6">
                                        <input class="input has-text-centered" type="number" id="minute"
                                        v-model="$v.minutes.$model" :class="{'is-danger': $v.minutes.$error}" name="menuMinute">
                                        <label class="label is-size-6 has-text-centered" style="color: #064635">Minutes</label>
                                        <template v-if="$v.minutes.$error">
                                            <p class="help is-danger" v-if="!$v.minutes.greaterThanZero" style="text-align: left">must greater than zero</p>
                                        </template>
                                    </div>
                                </div>

                                <!-- edit วัตถุดิบ -->
                                <div class="container is-flex">
                                    <input class="input mt-3 is-warning" type="text" placeholder="วัตถุดิบ"
                                        name="menuIngrediant" id="menuIngrediant" v-model="ingredient">
                                    <button class="button mt-3 ml-5" @click.prevent="addMaterial" id="btnMaterial" style="border-radius: 25px">Add material</button>
                                </div>
                                <div class="textarea mt-3 is-warning" placeholder="วัตถุดิบ" id="showIngrediant"
                                    style="height: 310px">
                                    <ol class="p-5">
                                        <li v-for="(item, index) in computedMaterials" :key="index">{{ item }} <i
                                                class="fa fa-minus" style="float: right;" id="deleteItem"
                                                @click.stop="deleteIngrediant(item, index)"></i></li>
                                    </ol>
                                </div>

                                <!-- กรอก วิธีทำอาหาร -->
                                <div class="container is-flex">
                                    <input class="input mt-3 is-warning" type="text" placeholder="วิธีทำ" name="menuMethod"
                                        id="menuMethod" v-model="howTo">
                                    <button class="button mt-3 ml-5" @click.prevent="addMethods" id="btnMethod" style="border-radius: 25px">Add method</button>
                                </div>
                                <div class="textarea mt-3 is-warning" placeholder="วิธีทำ" id="showMethod"
                                    style="height: 310px">
                                    <ol class="p-5">
                                        <li v-for="(item2, index) in computedMethods" :key="index">{{ item2 }}<i
                                                class="fa fa-minus" style="float: right;" id="deleteItem"
                                                @click.stop="deleteMethod(item2, index)"></i></li>
                                    </ol>
                                </div>

                                <div>
                                    <button @click="cancleEdit" class="button" id="cancleEditButton" style="margin-top: 20px; margin-right: 5px">
                                        <span>Cancle</span>
                                    </button>

                                    <button @click="saveMenu(menu.menu_id)" class="button" id="saveEditButton" style="margin-left: 5px">
                                        <span>Save</span>
                                        <span class="icon is-small">
                                            <i class="fas fa-edit"></i>
                                        </span>
                                    </button>
                                </div>

                            </div>
                        </div>

                        <div v-else>
                            <div class="is-size-4 has-text-centered mt-4 mb-4 ml-3 mr-3"
                                style="background-color: var(--yellow); border-radius:20px; border:5px solid #ffffff; position:sticky; top:0; z-index:5;">
                                <p>{{ menu.menu_name }}</p>
                            </div>
                            <!----------------- menu image ---------------------->
                            <figure class="image is-2by1 ml-6 mr-6 mt-3">
                                <img :src="menu.menu_image ? 'http://localhost:3000/uploads/' + menu.menu_image : 'https://bulma.io/images/placeholders/640x360.png'"
                                    alt="Placeholder image" style="object-fit:cover; border-radius:20px; border: 5px solid var(--cream);">
                            </figure>
                            <!-------------------------- comment-----------------------(start)--------------------------->
                            <!-- icon chat & like -----------------(start) -->
                            <div style="font-size: 20px; float:right ; margin-right:  50px; margin-top: 5px;">
                                <i class="fa-solid fa-comment" @click="show_comment(menu)" id="btnComment"></i>
                                <span @click="addLike(menu.menu_id)" id="btnLike" style="margin-left: 5px;">
                                    <i class="fa-solid fa-thumbs-up"></i>
                                    <span style="margin-left:5px">{{ menu.menu_id_count}}</span>
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
                                            @click="addComment(menu.menu_id)" >submit</button>
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
                                    <li v-for="(item, index) in computedMaterials" :key="index">{{ item }}</li>
                                </ol>
                            </div>
                            <!-- วิธีทำ -->
                            <div class="has-text-left m-1 mt-5"
                                style="border-radius: 20px; border: 3px solid #00000000; background: var(--cream-l)">
                                <p class="is-size-5 m-3 ml-4"><b>วิธีทำ</b></p>
                                <ol class="ml-6 mb-3 mr-6">
                                    <li v-for="(item, index) in computedMethods" :key="index">{{ item }}</li>
                                </ol>
                            </div>
                            <!-- ปุ่ม edit -->
                            <button @click="editMenu(menu, index_menu)" class="button is-warning" id="editButton">
                                <span>Edit</span>
                                <span class="icon is-small">
                                    <i class="fas fa-edit"></i>
                                </span>
                            </button>

                        </div>
                    </div>
                    <!-- add menu button -->
                    <!-- <button v-if="index===editToggle" class="button" @click="updateMenu(menu.menu_id, index)" id="addMenuButton" style="color: #064635; width: 200px;"><b>Update Menu</b></button> -->
                </div>

            </div>
        </div>
    </div>
</template>
<script>
import topbarVUE from './topBar.vue';
import sidemenubarVUE from './sideMenuBar.vue';
import axios from '@/plugins/axios' //+  axios interceptor
import {
    required,
  } from "vuelidate/lib/validators";

export default {
    props: ['user'], // รับ Props user มาจาก App.vue
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

            days: 0,
            hours: 0,
            minutes: 0,
            editToggle: -1,
            // for edit
            showeditmenu: null,
            edit_name: "",
            edit_image: "",
            images: [],
            category_nation: null,
            category_cooking: null,
            category_meat: null,
            select_nation: "",
            select_cooking: "",
            select_meat: "",

            ingredient: "",
            howTo: "",
            listMethods: [],
            listMaterials: [],
            //-------comment----------------
            isActive: false, // สถานะของ Modal
            comment_this_menu: null,
            comment: "",
            // ----------search----------
            search: "",
            //-----like
            statusLike: 0,

        };
    },
    created() {
        // console.log(this.$route.params.category_type)
        // console.log(this.$route.params.category_id)
        axios
            .get("http://localhost:3000/mymenu") // ****************** เพิ่ม params user_id *******************
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
        //เมื่อclick เลือกเมนูหรือดินสอ จะโชว์รายละเอียดเมนู
        showMenu(id) {
            axios.get('http://localhost:3000/showmenu/' + id
            ).then(response => {
                console.log("มาแล้ว", response.data)
                console.log("Toggle ", this.editToggle)
                console.log(this.showonemenu)

                this.showonemenu = response.data;
                let time = response.data[0].menu_duration
                // console.log(response.data[0].menu_duration)
                this.days = Math.floor(time / 1440); // 1 วันมี 1440 นาที
                this.hours = Math.floor((time % 1440) / 60); // 1 ชั่วโมงมี 60 นาที
                this.minutes = time % 60;

                this.listMaterials = this.menus[this.index_menu].menu_ingredients.split(",");
                this.listMethods = this.menus[this.index_menu].menu_methods.split(",");
                console.log(this.days, this.hours, this.minutes)
            })
                //-------------------------------------
                .catch(error => {
                    console.log(error.message);
                });
        },
        getMenuAgain(id) { // เรียกเมนูใหม่ หลังจากลบเมนู
            axios.get("http://localhost:3000/mymenu/")
                .then((response) => {
                    this.menus = response.data;

                })
                .catch((err) => {
                    console.log(err);
                });

            axios.get('http://localhost:3000/showmenu/' + id
            ).then(response => {
                console.log("มาแล้ว", response.data)
                console.log("Toggle ", this.editToggle)
                console.log(this.showonemenu)

                this.showonemenu = response.data;
                let time = response.data[0].menu_duration
                // console.log(response.data[0].menu_duration)
                this.days = Math.floor(time / 1440); // 1 วันมี 1440 นาที
                this.hours = Math.floor((time % 1440) / 60); // 1 ชั่วโมงมี 60 นาที
                this.minutes = time % 60;
                console.log(this.days, this.hours, this.minutes)

            })
        },
        deleteMenu(menu_id) {
            console.log("delete menu ", menu_id)
            const result = confirm(`Are you sure you want to delete this menu`);
            if (result) {
                axios
                    .delete('http://localhost:3000/showmenu/' + menu_id)
                    .then((response) => {
                        console.log(response)
                        this.getMenuAgain();
                    })
                    .catch((error) => {
                        alert(error.response.data.message);
                    });
            }

        },
        // update image
        loadImg(event) {
            console.log("click loadImg")
            this.images = event.target.files;
            console.log("loadImg", this.images)
            console.log("in showSelectImage", this.images[0].name)
            this.edit_image = this.images[0].name
        },
        showSelectImage(images) {
            // for preview only
            console.log("show", images)
            console.log("in showSelectImage", URL.createObjectURL(images))
            return URL.createObjectURL(images);
        },
        // กดเพิ่ม วัตถุดิบ 
        addMaterial() {
            console.log("click addMaterial")
            if (this.ingredient === ''){
                confirm('You must type ingredient before add.')
            }
            else{
                this.listMaterials.push(this.ingredient);
                this.ingredient = "";
            }
        },
        // กดเพิ่ม วิธีทำ
        addMethods() {
            console.log("click addMethods")
            if (this.howTo === ''){
                confirm('You must type method before add.')
            }
            else{
                this.listMethods.push(this.howTo);
                this.howTo = "";
            }
        },
        // edit Menu
        editMenu(menu, index) {
            this.editToggle = index
            this.edit_name = menu.menu_name
            this.edit_image = menu.menu_image
            this.select_nation = menu.category_nation
            this.select_cooking = menu.category_cooking
            this.select_meat = menu.category_meat
            this.listMaterials = menu.menu_ingredients.split(",");
            this.listMethods = menu.menu_methods.split(",");
            console.log("nationnn ", this.select_nation)
            axios
                .get("http://localhost:3000/categorys/")
                .then((response) => {
                    this.category_nation = response.data[0];
                    this.category_cooking = response.data[1];
                    this.category_meat = response.data[2];
                    console.log("front", this.category_nation);
                    console.log("front", this.category_meat);
                    console.log("front", this.category_cooking);
                })
                .catch((err) => {
                    console.log(err);
                });
        },
        saveMenu(menu_id) {
            let formData = new FormData();
            formData.append("name", this.edit_name);
            formData.append("id", menu_id);
            if (this.images[0] == null) {
                formData.append("image", "not_change");
            } else {
                formData.append("image", this.images[0]);
            }
            formData.append("nation", this.select_nation)
            formData.append("cooking", this.select_cooking)
            formData.append("meat", this.select_meat)
            formData.append("duration", (this.days * 1440) + (this.hours * 60) + this.minutes)
            formData.append("ingredients", this.listMaterials)
            formData.append("methods", this.listMethods)

            axios.put(`http://localhost:3000/updates`, formData)
                .then((response) => {
                    console.log("thenn ", response.data.data[0].menu_id)
                    this.editToggle = -1;
                    this.getMenuAgain(response.data.data[0].menu_id)
                }).catch((error) => {
                    this.error = error.message;
                })
        },
        cancleEdit(){
            this.editToggle = -1
        },
        deleteIngrediant(item, index) {
            const result = confirm(`Are you sure you want to delete this Ingrediant ` + item);
            if (result) {
                console.log("delete Ingrediant --> ", item, index);
                console.log("list --> ", this.listMaterials);
                const removeIng = this.listMaterials.splice(index, 1)
                console.log("delete --> ", removeIng);
            }

        },
        deleteMethod(item, index) {
            const result = confirm(`Are you sure you want to delete this Method ` + item);
            if (result) {
                console.log("delete Method --> ", item, index);
                console.log("list --> ", this.listMethods);
                const removeIng = this.listMethods.splice(index, 1)
                console.log("delete --> ", removeIng);
            }

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
        deleteComment(comment, comment_id, menu_id){
            console.log("comment --> ", comment);
            console.log("comment_id --> ", comment_id);
            const result = confirm(`Are you sure you want to delete this comment`);
            if (result){
                axios
                    .delete('http://localhost:3000/comment/' + comment_id + "/" + menu_id)
                    .then((response) => {
                        console.log("delete",response.data)
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
                    // this.getCategories(menu_id);
                    this.getMenuAgain(menu_id);
                })
                .catch((err) => {
                    console.log(err);
                });
        },
        // เรียกเมนูที่ search มาแสดง
        getSearch() {
            console.log("Front Search in Allmenu.vue : ", this.search)
            axios.get("http://localhost:3000/mymenu" , {
                params: {
                    search_value: this.search
                }
            })
                .then((response) => {
                    console.log('response.data - MyMenu.vue ', response.data);
                    this.menus = response.data
                })
                .catch((error) => {
                    console.log(error);
                });
        },
        callMenuAgain(){
            axios
            .get("http://localhost:3000/mymenu")
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
        computedMaterials() {
            console.log("in list-materail", this.listMaterials)
            return this.listMaterials;
        },
        computedMethods() {
            console.log("in list-methods", this.listMethods)
            return this.listMethods;
        },
        checkSearch(){
            if (this.search == ''){
                return this.callMenuAgain()
            }
            return this.getSearch()
        }
    },
    validations: {
        edit_name: {
            required: required,
        },
        days: {
            greaterThanZero: value => value >= 0
        },
        hours: {
            greaterThanZero: value => value >= 0
        },
        minutes: {
            greaterThanZero: value => value >= 0
        },
    }
};
</script>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Lobster+Two:ital@1&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Lobster+Two:ital@1&family=Montserrat+Alternates&display=swap');

.comment {
    overflow-y: scroll;
    height: 400px;
}

.comment::-webkit-scrollbar {
    width: 20px;
}

/* Track */
.comment::-webkit-scrollbar-track {
    margin-top: 40px;
    margin-bottom: 40px;
    border-radius: 100px;
}

/* Handle */
.comment::-webkit-scrollbar-thumb {
    background: var(--cream);
    border-radius: 100px;
    border: 5px solid transparent;
    background-clip: content-box;
}


/* ------test-modal-bulma----- */

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
    margin-top: 20px;
    width: 90%;
}

#imageBox {
    width: 85%;
    height: 320px;
    background-repeat: no-repeat;
    background-size: cover;
    background-color: var(--cream);
    border-radius: 30px;
    border-color: var(--yellow);
    margin-top: 20px;
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

#editButton{
    margin-top: 20px;
}

#saveEditButton{
    margin-top: 20px;
    background-color: var(--cream);
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
    margin-top: 27px;
    width: 200px;
    position: relative;
    /* top: 0; */
    left: 1%;
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