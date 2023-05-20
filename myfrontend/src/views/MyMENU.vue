<template>
    <div>
        <topbarVUE />
            <div class="columns is-max-desktop inside" id="list_menu">
                <sidemenubarVUE />

            <!---------------------------------------------- category ------------------------------------------------->
            
            <div class="column list-fav-menu">

                <!-- start form menu  -->
                <table class="table is-fullwidth" id="fav-menu" v-for="(menu,index) in menus" :key="index"
                :class="[{ 'has-background-warning-light': menu.is_favorite }]"
                    @click="showMenu(menu.menu_id), select_menu = true, index_menu = index">
                    <!-- @click="select_menu = true, index_menu = index" -->
                    <tr>
                        <td rowspan="4" style="width: 128px">
                            <figure class="image is-128x128" style="border: 5px solid var(--cream-l);">
                                <img :src="menu.menu_image ? 'http://localhost:3000/uploads/'+ menu.menu_image : 'https://bulma.io/images/placeholders/640x360.png'"
                                                alt="Placeholder image"  style="height: 100%; object-fit:contain;">
                            </figure>
                        </td>
                        <td><b>ชื่อเมนู</b> : {{ menu.menu_name }} </td>
                        <td rowspan="2">
                            <div class="icon is-size-4"> <!-- @click.stop="menu.is_favorite = !menu.is_favorite" -->
                                <!-- ดินสอ (ยังไม่กด) -->
                                <!-- <span class="icon" id="icon_pen" @click.stop="editMenu(menu, index)">
                                    <i class="fa fa-pen"></i>
                                </span> -->
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
                    select Select Your Menu To Show
                </p>
                <!-- select menu true -->

                <div v-for="(menu, index) in showonemenu" :key="index">
                    <!-- แสดงรายละเอียดเมนูเมื่อคลิกเลือก -->
                    <div v-if="select_menu == true">
                        <div v-if="index_menu === editToggle">
                            <div class="content">
                                <input v-model="edit_name" class="input" type="text" />
                                <!-- edit image -->
                                <label class="image is-2by1 container p-6" for="file" id="imageBox">
                                    <img :src="(edit_image == menu.menu_image) ? 'http://localhost:3000/uploads/' + edit_image : showSelectImage(images[0])"
                                        style="object-fit:cover; border-radius:20px; border: 5px solid var(--cream);" />
                                    <input type="file" accept="image/*" name="images" id="file" @change="loadImg"
                                        style="display: none;">
                                    <span class="icon is-large" id="aboutImg">
                                        <i class="fas fa-images is-large"
                                            style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);"></i>
                                        <p style="position: absolute; top: 60%; left: 50%; transform: translate(-50%);">Browse
                                            Image
                                        </p>
                                    </span>
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
                                        <input class="input has-text-centered" type="number" id="day" v-model="days" name="menuDay">
                                        <label class="label is-size-6 has-text-centered" style="color: #064635">Days</label>
                                    </div>
                                    <div class="container mr-4 ml-4">
                                        <input class="input has-text-centered" type="number" id="hour" v-model="hours" name="menuHour">
                                        <label class="label is-size-6 has-text-centered" style="color: #064635">Hours</label>
                                    </div>
                                    <div class="container ml-4 mr-6">
                                        <input class="input has-text-centered" type="number" id="minute" v-model="minutes"
                                            name="menuMinute">
                                        <label class="label is-size-6 has-text-centered" style="color: #064635">Minutes</label>
                                    </div>
                                </div>

                                <!-- edit วัตถุดิบ -->
                                <div class="container is-flex">
                                    <input class="input mt-3 is-warning" type="text" placeholder="วัตถุดิบ" name="menuIngrediant"
                                        id="menuIngrediant" v-model="ingredient">
                                    <button class="button mt-3 ml-5" @click.prevent="addMaterial"
                                        style="width:100px; background-color: #F0BB62;">Add material</button>
                                </div>
                                <div class="textarea mt-3 is-warning" placeholder="วัตถุดิบ" id="showIngrediant" style="height: 310px">
                                    <ol class="p-5">
                                        <li v-for="(item, index) in computedMaterials" :key="index">{{ item }}</li>
                                    </ol>
                                </div>

                                <!-- กรอก วิธีทำอาหาร -->
                                <div class="container is-flex">
                                    <input class="input mt-3 is-warning" type="text" placeholder="วิธีทำ" name="menuMethod"
                                        id="menuMethod" v-model="howTo">
                                    <button class="button mt-3 ml-5" @click.prevent="addMethods"
                                        style="width:100px; background-color: #F0BB62;">Add method</button>
                                </div>
                                <div class="textarea mt-3 is-warning" placeholder="วิธีทำ" id="showMethod" style="height: 310px">
                                    <ol class="p-5">
                                        <li v-for="(item2, index) in computedMethods" :key="index">{{ item2 }}</li>
                                    </ol>
                                </div>

                                <button @click="saveMenu(menu.menu_id)" class="button is-primary">
                                    <span>Save</span>
                                    <span class="icon is-small">
                                        <i class="fas fa-edit"></i>
                                    </span>
                                </button>
                            </div>
                        </div>
                        
                    <div v-else>
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
                            <p class="ml-5"><b>Nation : </b>{{ menu.nation_name }} Food </p>
                            <p class="ml-5"><b>Method : </b>{{ menu.cooking_name }}</p>
                            <p class="ml-5"><b>Meat : </b>{{ menu.meat_name }} </p>
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
                        <button @click="editMenu(menu, index_menu)" class="button is-warning">
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

            days:0,
            hours:0,
            minutes:0,
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
        deleteMenu(menu_id){
            console.log("delete menu ", menu_id)
            const result = confirm('Delete Your Menu')
            if (result){
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
            this.listMaterials.push(this.ingredient);
            this.ingredient = "";
        },
        // กดเพิ่ม วิธีทำ
        addMethods() {
            console.log("click addMethods")
            this.listMethods.push(this.howTo);
            this.howTo = "";
        },
        // edit Menu
        editMenu(menu, index){
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
        saveMenu(menu_id){
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
            formData.append("duration", (this.days*1440)+(this.hours*60)+this.minutes)
            formData.append("ingredients",this.listMaterials)
            formData.append("methods",this.listMethods)

            axios.put(`http://localhost:3000/updates`, formData)
                .then((response) => {
                    console.log("thenn ", response.data.data[0].menu_id)
                    this.editToggle = -1;
                    this.getMenuAgain(response.data.data[0].menu_id)
                }).catch((error) => {
                    this.error = error.message;
            })
        }

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
    },
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