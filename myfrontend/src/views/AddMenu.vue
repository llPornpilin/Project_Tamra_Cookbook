<template>
    <div>
        <topBarVUE />
        <div class="columns is-max-desktop inside">
            <sideMenuBarVUE />
            <!------------------------------ Add Menu -------------------------------------->
            <form class="column pr-5 pl-5" id="list_menu" action="/mymenu" enctype="multipart/form-data" method="POST">
                <!-------------- foodName -------------------->
                <div class="column is-6 mr-4 p-6" id="leftPage">
                    <!-- กรอก ชื่ออาหาร -->
                    <input class="input mt-3 is-warning" type="text" placeholder="ชื่อเมนู" name="menuName" id="menuName"
                        v-model="menu_name">

                    <!-- กรอก วัตถุดิบ -->
                    <div class="container is-flex">
                        <input class="input mt-3 is-warning" type="text" placeholder="วัตถุดิบ" name="menuIngrediant"
                            id="menuIngrediant" v-model="ingredient">
                        <button class="button mt-3 ml-5" @click.prevent="addMaterial"
                            style="width:100px; background-color: #F0BB62;">Add material</button>
                    </div>
                    <div class="textarea mt-3 is-warning" placeholder="วัตถุดิบ" id="showIngrediant" style="height: 310px">
                        <ol class="p-5">
                            <li v-for="(item, index) in listMaterials" :key="index">{{ item }}</li>
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
                            <li v-for="(item2, index) in listMethods" :key="index">{{ item2 }}</li>
                        </ol>
                    </div>
                </div>
                <!--------------- foodCategory ----------------->
                <div class="column p-6" id="rightPage">
                    <!-- menu image -->
                    <label class="image is-2by1 container p-6" for="file" id="imageBox">
                        <img v-for="(image, index) in images" :key="index" :src="showSelectImage(image)"
                            style="border-radius: 30px;">
                        <input type="file" accept="image/*" name="images" id="file" @change="loadImg"
                            style="display: none;">
                        <!-- <span class="icon is-large" id="aboutImg" :style="{ display: iconDisplay }"> -->
                        <span class="icon is-large" id="aboutImg">
                            <i class="fas fa-images is-large"
                                style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);"></i>
                            <p style="position: absolute; top: 60%; left: 50%; transform: translate(-50%);">Browse Image
                            </p>
                        </span>
                    </label>
                    <!-- dropdown -->
                    <div class="p-5">
                        <div class="mt-3 is-flex">
                            <label class="label">Menu Nation</label>
                            <select v-model="nation" name="menuCategory">
                                <option v-for="(nation, index) in category_nation" :key="index" :value="nation.nation_id">{{
                                    nation.nation_name }}
                                </option>
                            </select>
                        </div><br>
                        <div class="mt-3 is-flex">
                            <label class="label">Type Cooking</label>
                            <select v-model="method" name="menuTypeCook">
                                <option v-for="(typecook, index) in category_cooking" :key="index"
                                    :value="typecook.cooking_id">{{ typecook.cooking_name
                                    }}</option>
                            </select>
                        </div><br>
                        <div class="mt-3 is-flex">
                            <label class="label">Type Meat</label>
                            <select v-model="meat" name="menuTypeMeat">
                                <option v-for="(typemeat, index) in category_meat" :key="index" :value="typemeat.meat_name">
                                    {{ typemeat.meat_name }}
                                </option>
                            </select>
                        </div>
                    </div>
                    <!-- spending time -->
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
                    <!-- add menu button -->
                    <!-- <button class="button" @click="addMenu()" id="addMenuButton" style="color: #064635; width: 200px;"><b>Add Menu</b></button> -->
                    <button class="button" type="submit" id="addMenuButton" style="color: #064635; width: 200px;"
                        @click.prevent="addMenu"><b>Add Menu</b></button>

                </div>
            </form>
        </div>
    </div>
</template>

<script>

import topBarVUE from './topBar.vue';
import sideMenuBarVUE from './sideMenuBar.vue';
// import axios from "axios";
import axios from '@/plugins/axios' //+

export default {
    components: {
        topBarVUE,
        sideMenuBarVUE
    },
    data() {
        return {
            //เก็บค่า ที่ทำการกรอก
            menu_name: '', //ชื่อเมนูที่กรอก
            ingredient: '', //วัตถุกดิบที่กรอก 1 
            howTo: '', //วิธีทำที่กรอก 1
            days: '0',
            hours: '0',
            minutes: '0',
            //--------------------------------
            materials: ["ใจเย็น", "ใกล้ละ"],
            methods: ["ตั้งสติ", "ดูให้รอบครอบ"],
            images: [],
            category_nation: null,
            category_meat: null,
            category_cooking: null,
            // v-model -----------------------
            nation: '',
            method: '',
            meat: '',
        };
    },
    created() {
        axios
            .get("http://localhost:3000/categorys/")
            .then((response) => {
                this.category_nation = response.data[0];
                this.category_cooking = response.data[1];
                this.category_meat = response.data[2];
                // console.log(response.data)
                console.log("front", this.category_nation);
                console.log("front", this.category_meat);
                console.log("front", this.category_cooking);
            })
            .catch((err) => {
                console.log(err);
            });
    },
    methods: {
        addMaterial() {
            console.log("click addMaterial")
            this.materials.push(this.ingredient);
            this.ingredient = "";
        },
        addMethods() {
            console.log("click addMethods")
            this.methods.push(this.howTo);
            this.howTo = "";

        },
        loadImg(event) {
            console.log("click loadImg")
            this.images = event.target.files;
            console.log(this.images)
        },
        showSelectImage(images) {
            // for preview only
            console.log("in showSelectImage")
            return URL.createObjectURL(images);
        },
        addMenu() {
            console.log("click addMenu")
            let formData = new FormData();
            formData.append("menuName", this.menu_name);
            formData.append("menuIngredient", this.materials);
            formData.append("menuHowTo", this.methods);
            // time cooking
            formData.append("days", this.days);
            formData.append("hours", this.hours);
            formData.append("minutes", this.minutes);
            // userId
            formData.append("userId", 1);
            // v-model ------------------------------------------
            formData.append("nation", this.nation);
            formData.append("method", this.method);
            formData.append("meat", this.meat);
            // image
            console.log("click submit", this.images)
            this.images = Array.from(this.images);
            this.images.forEach((images) => {
                formData.append("images", images);
            });
            axios
                .post("http://localhost:3000/addMenu/", formData)
                .then(() => this.$router.push({ name: 'HomePage' }))
                .catch((e) => console.log(e.response.data));
            console.log("axios")
        }
    },
    computed: {
        listMaterials() {
            console.log("in list-materail", this.materials)
            return this.materials;
        },
        listMethods() {
            console.log("in list-methods", this.methods)
            return this.methods;
        },
    },
};

</script>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Lobster+Two:ital@1&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Lobster+Two:ital@1&family=Montserrat+Alternates&display=swap');

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

/*----------- add info ---------------*/
#list_menu {
    display: flex;
    background-color: var(--darkgreen);
    border-radius: 30px;
}

#leftPage,
#rightPage {
    background-color: #fbf8d2;
    border-radius: 30px;
}

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
    position: absolute;
    left: 74%;
}


/* scroll bar */
/* width */
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
}</style>