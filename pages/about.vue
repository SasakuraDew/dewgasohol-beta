<template>
    <div class="parallax-container">
        <div class="parallax-background"></div>
        <div class="content-section">
            <V-container>
                <V-row>
                    <V-col color="white" class="text-center">
                        <V-card color="white">
                            <V-card-title class="black--text">
                                <V-icon left color="blue">mdi-information</V-icon>
                                เกี่ยวกับ Dewgasohol
                            </V-card-title>
                            <V-card-text class="black--text">
                                นี่คือโครงสร้างใหม่ทั้งหมด เนื่องจากไม่ถถูกใจ Ai เลยเขียนเองซะเลย 5555+
                            </V-card-text>
                        </V-card>
                    </V-col>
                </V-row>
            </V-container>
        </div>
    </div>
</template>

<script>
</script>

<style scoped>
.parallax-container {
    position: relative;
    width: 100vw;
    min-height: 100vh;
}
.parallax-background {
    position: fixed;
    top: 0;
    left: 0;
    width: 100vw;
    height: 100vh;
    background-image: url('https://images.unsplash.com/photo-1506744038136-46273834b3fb?q=80&w=2070&auto=format&fit=crop');
    background-size: cover;
    background-position: center;
    z-index: 1;
}
.content-section {
    position: relative;
    z-index: 2;
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
}
v-container, v-row, v-col, v-card {
    position: relative;
    z-index: 2;
}
</style>