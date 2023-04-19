<template>
    <!-- top bar -->
    <section class="hero is-small" id="top">
        <div class="hero-body is-flex">
            <div class="container">
                <h6 class="title is-size-4 has-text-centered has-text-weight-bold">
                    <b>Tamra Cookbook</b>
                </h6>
            </div>
            <form action="">
                <input class="input" type="text" placeholder="Search Menu ..." id="search" name="search">
                <button class="button" type="submit" id="searchButton"><i class="fas fa-search"></i></button>
            </form>
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
</style>