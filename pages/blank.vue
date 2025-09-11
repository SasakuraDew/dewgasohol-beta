<template>
  <div class="redirect-container">
    <div class="redirect-box">
      <h1>ไม่มีสิทธิ์เข้าถึง</h1>
      <p>คุณไม่มีสิทธิ์ในการเข้าถึงหน้านี้</p>
      <p class="countdown">กำลังกลับไปหน้าเข้าสู่ระบบในอีก {{ countdown }} วินาที...</p>
      <a href="/deep_link/user_signin">กลับไปหน้าเข้าสู่ระบบทันที</a>
    </div>
  </div>
</template>

<script>
export default {
  layout: 'blank', // ใช้ layout ว่างๆ ถ้ามี
  data() {
    return {
      countdown: 3,
      intervalId: null
    };
  },
  mounted() {
    this.startCountdown();
  },
  beforeDestroy() {
    // Clear the interval when the component is destroyed to prevent memory leaks
    clearInterval(this.intervalId);
  },
  methods: {
    startCountdown() {
      this.intervalId = setInterval(() => {
        this.countdown--;
        if (this.countdown === 0) {
          clearInterval(this.intervalId);
          this.$router.push('/deep_link/user_signin');
        }
      }, 1000);
    }
  }
};
</script>

<style scoped>
.redirect-container {
  display: flex;
  align-items: center;
  justify-content: center;
  min-height: 100vh;
  background-color: #f4f7f6;
  font-family: sans-serif;
  text-align: center;
}
.redirect-box {
  background: white;
  padding: 3rem 4rem;
  border-radius: 8px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
}
h1 {
  color: #d9534f; /* Red color for error */
  font-size: 2rem;
  margin-bottom: 0.5rem;
}
p {
  color: #555;
  font-size: 1.1rem;
}
.countdown {
  margin-top: 1.5rem;
  font-weight: bold;
  color: #333;
}
a {
    display: inline-block;
    margin-top: 1rem;
    color: #007bff;
    text-decoration: none;
}
a:hover {
    text-decoration: underline;
}
</style>
