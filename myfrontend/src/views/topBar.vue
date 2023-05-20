<template>
    <!-- top bar -->
    <section class="hero is-small" id="top">
        <!-- <div class="hero-body is-flexd">
            <b class="title is-size-4 has-text-centered has-text-weight-bold">Tamra Cookbook</b>
            <input v-model="search" class="input has-text-right" type="text" placeholder="Search Menu ..." id="search" name="search">
            <button class="button" id="searchButton" @click="getMenus"><i class="fas fa-search"></i></button>
        </div> -->
        <div class="hero-body">
            <div class="columns is-centered">
                <div class="column is-10">
                    <b class="title is-size-4 has-text-centered has-text-weight-bold">Tamra Cookbook</b>
                </div>
                <!-- <div class="column is-flex is-justify-content-flex-end" id="searchArea">
                    <input v-model="search" class="input has-text-left" type="text" placeholder="Search Menu ..."
                        id="search" name="search">
                    <button class="button" id="searchButton" @click="getMenus"><i class="fas fa-search"></i></button>
                </div> -->

            </div>
        </div>
    </section>
</template>
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
#searchArea{
    background-color: white;
    border-radius: 30px ;
    padding: 0;
    height: fit-content;
}
#search{
    width: 250px;
    border-radius: 30px;
    border: none;
}
#searchButton{
    border-radius: 50px;
    border: none;
}
</style>