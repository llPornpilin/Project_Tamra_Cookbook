var app = new Vue({
    el: '#cate',
    data: {
        checkActive1: false,
        checkActive2: false,
        checkActive3: false,
        nations: [
            {
                name: "Chinese",
                image: "/img/chinese_food.jpg",
                flag: "/img/china_flag.png"
            },
            {
                name: "Thai",
                image: "/img/thai_food.jpg",
                flag: "/img/thailand_flag.jpg"
            },
            {
                name: "Korean",
                image: "/img/korean_food.jpg",
                flag: "/img/korea_flag.jpg"
            },
            {
                name: "Japanese",
                image: "/img/japanese_food.jpg",
                flag: "/img/japan_flag.jpg"
            },
            {
                name: "Indian",
                image: "/img/indian_food.jpg",
                flag: "/img/india_flag.jpg"
            },
            {
                name: "Italian",
                image: "/img/italian_food.jpg",
                flag: "/img/italy_flag.png"
            },
            {
                name: "Others Inter",
                image: "/img/other_inter_food.jpg",
                flag: ""
            },
            {
                name: "Others",
                image: "/img/other.jpg",
                flag: ""
            }
        ],

        typecooks: [
            {
                name: "Fried Food", //ทอด
                image: "/img/fried_food.jpg"
            },
            {
                name: "Stirred Food", //คน
                image: "/img/stirred_food.jpg"
            },
            {
                name: "Boiled Food", //ต้ม
                image: "/img/boiled_food.jpg"
            },
            {
                name: "Grilled Food", //ย่าง
                image: "/img/grilled_food.jpg"
            },
            {
                name: "Baked Food", //อบ
                image: "/img/baked_food.png"
            },
            {
                name: "Steamed Food", //นึ่ง
                image: "/img/streamed_food.jpg"
            }
        ],

        typemeats: [
            {
                name: "Pork",
                image: "/img/pork.jpg"
            },
            {
                name: "Chicken",
                image: "/img/chicken.jpg"
            },
            {
                name: "Duck",
                image: "/img/duck.jpg"
            },
            {
                name: "Beef",
                image: "/img/beef.jpg"
            },
            {
                name: "Mutton",
                image: "/img/mutton.jpg"
            },
            {
                name: "Fish",
                image: "/img/fish.jpeg"
            },
            {
                name: "Shellfish",
                image: "/img/shellfish.jpg"
            },
            {
                name: "Crab",
                image: "/img/crabb.jpg"
            },
            {
                name: "Shrimp",
                image: "/img/shrimp.jpg"
            },
            {
                name: "Squid",
                image: "/img/squid.jpg"
            },
            {
                name: "Other Meat",
                image: "/img/other_meat.jpg"
            },
        ]
    },
    methods: {
        nextPage(id) {
            const myJSON = JSON.stringify(id);
            localStorage.setItem("ID", myJSON);
            window.location.href = "./Allmenu.html";
        },
    }
})