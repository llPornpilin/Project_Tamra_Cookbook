var app1 = new Vue({
    el: "#list_menu",
    methods: {
        findIndex(menu, index) {
            select_menu = false;
        },
        isFavorite(menu){
            console.log(menu);
            console.log(menu.id_menu);
            menu.is_favorite = !menu.is_favorite;
            const myJSON = JSON.stringify(this.products);
            localStorage.setItem("all_menu", myJSON);
        },
        addMenu(){
            // add menu info
            this.products.push({"id_menu": this.id_menu, "id_create":1, "name": this.name, "meat": this.meat, "method": this.method, 
            "category": this.category, "is_favorite": this.is_favorite, "select_show": this.select_show, "image": this.image, "days": this.days,
            "hours": this.hours, "minutes": this.minutes, "material": this.material, "methods": this.methods});

            this.id_menu++;
            // local storage
            const myJSON = JSON.stringify(this.products);
            localStorage.setItem("all_menu", myJSON);
            this.name = "";
            this.meat = "Pork";
            this.method = "Fried Food";
            this.category = "Chinese";
            this.image = "";
            this.methods = [];
            this.material = [];
            this.days = "0";
            this.hours = "0";
            this.minutes = "0";    
        },
        // on change image
        loadImg(event){
            const file = event.target.files[0];
            this.image = URL.createObjectURL(file);
            this.iconDisplay = 'none';
        },
        // เพิ่มวัตถุดิบทีละข้อลง array
        addMaterial(){
            this.material.push(this.ingrediant);
            this.ingrediant = "";
        },
        // เพิ่มวิธีทำทีละข้อลง array
        addMethods(){
            this.methods.push(this.howTo);
            this.howTo = "";
        },
        //หน้า update menu
        setMenuNew(menu){
            console.log(menu);
            this.name = menu.name;
            this.meat = menu.meat;
            this.method = menu.method;
            this.category = menu.category;
            this.image = menu.image;
            this.days = menu.days;
            this.hours = menu.hours;
            this.minutes = menu.minutes;
            this.material = menu.material;
            this.methods = menu.methods;
        },
        addMaterial_mymenu(index_menu){
            console.log( this.products[index_menu].material)
            this.products[index_menu].material.push(this.ingrediant);
            // const myJSON = JSON.stringify(this.products);
            // localStorage.setItem("all_menu", myJSON);
            this.ingrediant = "";
        },
        addMethods_mymenu(index_menu){
            this.products[index_menu].methods.push(this.howTo);
            // const myJSON = JSON.stringify(this.products);
            // localStorage.setItem("all_menu", myJSON);
            this.howTo = "";
        },
        delete_menu(menu, index){
            this.products.splice(index, 1);
            const myJSON = JSON.stringify(this.products);
            localStorage.setItem("all_menu", myJSON);
        },
        updateMenu(index_menu,menu){
            this.products.splice(index_menu, 1);
            // add menu info
            this.products.push({"id_menu": this.id_menu, "id_create":1, "name": this.name, "meat": this.meat, "method": this.method, 
            "category": this.category, "is_favorite": this.is_favorite, "select_show": this.select_show, "image": this.image, "days": this.days,
            "hours": this.hours, "minutes": this.minutes, "material": this.material, "methods": this.methods});

            this.id_menu++;
            // local storage
            const myJSON = JSON.stringify(this.products);
            localStorage.setItem("all_menu", myJSON);
        }
    },

    created() {

        let text = localStorage.getItem("ID");
        this.select_id = JSON.parse(text);
        console.log(this.select_id);

        let all = localStorage.getItem("all_menu");
        if(all){
            this.products = JSON.parse(all);
        }

    },
    computed: {
        test() {
            var result = this.products.filter(
            (products) =>
                products.category === this.select_id ||
                products.method === this.select_id ||
                products.meat === this.select_id
            );
            console.log(result);
            return result;
        },
        favorite_at_all(){
            const result = this.products.filter(
                (products) =>
                    products.is_favorite === true
            );

            console.log(result);
            return result;
        },
        list_material(){
            return this.material;
        },
        list_methods(){
            return this.methods;
        },
        my_menu_all(){
            const result = this.products.filter(
                (products) =>
                    products.id_create === 1
            );

            console.log(result);
            return result;
        },
    },
});
