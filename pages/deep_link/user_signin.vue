<template>
    <div class="signin-bg">
        <div class="signin-layout">
            <!-- ส่วนด้านซ้ายสำหรับโลโก้ -->
            <div class="signin-left">
                <div class="signin-adobe-logo">
                    <img src="https://upload.wikimedia.org/wikipedia/commons/4/4e/Adobe_Corporate_Logo.png" alt="Logo" />
                    <div class="signin-adobe-text">
                        <span>DEWGASOHOL</span>
                        <div class="signin-adobe-desc">Sign in or create an account</div>
                    </div>
                </div>
            </div>

            <!-- การ์ดลงชื่อเข้าใช้ (ส่วนด้านขวา) -->
            <div class="signin-card">
                <div class="signin-content">
                    <div class="signin-header">
                        <h2>Sign in</h2>
                        <div class="signin-newuser">New user? <nuxt-link to="/deep_link/user_create_an_account">Create an account</nuxt-link></div>
                    </div>

                    <label class="signin-label" for="email-input">Email address</label>
                    <input id="email-input" class="signin-input" type="email" placeholder="Enter your email" v-model="email" />

                    <label class="signin-label" for="password-input">Password</label>
                    <input id="password-input" class="signin-input" type="password" placeholder="Enter your password" v-model="password" @keyup.enter="signIn"/>

                    <div v-if="errorMsg" style="color:red; margin-bottom:10px">{{ errorMsg }}</div>

                    <button class="signin-continue" @click="signIn">Continue</button>

                    <div class="signin-or"><span>Or</span></div>

                    <button class="social-btn google-btn">
                        <img class="social-icon" src="https://www.vectorlogo.zone/logos/google/google-icon.svg" alt="Google"/>
                        <span>Continue with Google</span>
                    </button>
                    <button class="social-btn facebook-btn">
                        <img class="social-icon" src="https://www.vectorlogo.zone/logos/facebook/facebook-icon.svg" alt="Facebook"/>
                        <span>Continue with Facebook</span>
                    </button>

                    <a class="signin-more-options" href="#">More sign-in options</a>
                    <a class="signin-help" href="#">Get help signing in</a>
                </div>
            </div>
        </div>

        <footer class="signin-footer">
            <span>Copyright © 2025 DEWGASOHOL. All rights reserved.</span>
        </footer>

        <button class="help-button">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M9.09 9a3 3 0 0 1 5.83 1c0 2-3 3-3 3"></path><line x1="12" y1="17" x2="12.01" y2="17"></line></svg>
        </button>
    </div>
</template>

<script>
export default {
    data() {
        return {
            email: '',
            password: '',
            errorMsg: ''
        }
    },
    methods: {
        async signIn() {
            this.errorMsg = '';
            if (!this.email || !this.password) {
                this.errorMsg = 'Please enter email and password';
                return;
            }
            try {
                await this.$store.dispatch('auth/login', { 
                    email: this.email, 
                    password: this.password 
                });
                this.$router.push('/member/profile');
            } catch (error) {
                this.errorMsg = error.message || 'Invalid email or password';
            }
        }
    }
}
</script>

<style scoped>
/* --- Base and Background --- */
.signin-bg {
    min-height: 100vh;
    width: 100%;
    font-family: system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
    color: #333;
    position: fixed;
    top: 0;
    left: 0;
    background: url('https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=1500&q=80') no-repeat center center;
    background-size: cover;
    z-index: 0;
    overflow-y: auto; /* ยังคงจำเป็นสำหรับหน้าจอเล็กมากๆ ที่ทั้งหน้าต้องเลื่อน */
    overflow-x: hidden;
}

/* --- Layout --- */
.signin-layout {
    display: flex;
    justify-content: flex-end;
    align-items: center; /* จัดให้อยู่กลางแนวตั้ง */
    min-height: 100vh;
    width: 100%;
    padding: 2rem;
    box-sizing: border-box;
    position: relative;
    z-index: 2;
}

/* --- Logo (Left Side) --- */
.signin-left {
    position: absolute;
    bottom: 60px;
    left: 60px;
}
.signin-adobe-logo {
    display: flex;
    align-items: center;
    gap: 12px;
}
.signin-adobe-logo img {
    width: 44px;
    height: 40px;
}
.signin-adobe-text {
    color: #fff;
    font-weight: bold;
    font-size: 1.5rem;
    text-shadow: 0 1px 3px rgba(0,0,0,0.3);
}
.signin-adobe-desc {
    font-size: 1rem;
    font-weight: 400;
    margin-top: -2px;
}

/* --- Sign-in Card (Right Side) --- */
.signin-card {
    background: #fff;
    border-radius: 8px;
    box-shadow: 0 8px 32px rgba(0,0,0,0.2);
    max-width: 420px;
    width: 100%;
    margin: 0 5vw 0 0;
    display: flex;
    flex-direction: column;
    z-index: 3;
    /* --- [การแก้ไขหลัก] --- */
    max-height: 85vh; /* 1. กำหนดความสูงสูงสุดไม่ให้เกิน 85% ของความสูงหน้าจอ */
    overflow-y: auto; /* 2. เพิ่ม scrollbar อัตโนมัติเมื่อเนื้อหาเกินความสูงที่กำหนด */
}

.signin-content {
    padding: 1.5rem 2.5rem 2rem 2.5rem;
    display: flex;
    flex-direction: column;
}

/* --- Card Header --- */
.signin-header {
    text-align: left;
    margin-bottom: 1.5rem;
}
.signin-header h2 {
    font-size: 1.75rem;
    font-weight: 700;
    margin: 0 0 0.25rem 0;
}
.signin-newuser {
    font-size: 1rem;
}
.signin-newuser a {
    color: #1473e6;
    text-decoration: none;
    font-weight: 500;
}
.signin-newuser a:hover {
    text-decoration: underline;
}

/* --- Form Elements --- */
.signin-label {
    font-size: 0.85rem;
    margin-bottom: 0.3rem;
    font-weight: bold;
    color: #555;
    text-align: left;
}
.signin-input {
    border: 1px solid #c0c0c0;
    border-radius: 4px;
    padding: 0.75rem 0.9rem;
    font-size: 1rem;
    margin-bottom: 1.2rem;
    transition: border-color 0.2s;
}
.signin-input:focus {
    outline: none;
    border-color: #1473e6;
    box-shadow: 0 0 0 1px #1473e6;
}
.signin-continue {
    background: #1473e6;
    color: #fff;
    border: none;
    border-radius: 24px;
    padding: 0.7rem 1.5rem;
    font-size: 1rem;
    font-weight: 600;
    cursor: pointer;
    align-self: flex-end;
    margin-top: 1.5rem; /* เพิ่มระยะห่างด้านบน */
    transition: background 0.2s;
}
.signin-continue:hover {
    background: #0d66d0;
}

/* --- "Or" Separator --- */
.signin-or {
    display: flex;
    align-items: center;
    text-align: center;
    color: #888;
    margin: 1.2rem 0;
}
.signin-or::before, .signin-or::after {
    content: '';
    flex: 1;
    border-bottom: 1px solid #e0e0e0;
}
.signin-or span {
    padding: 0 1rem;
    font-size: 0.9rem;
}

/* --- Social Login Buttons --- */
.social-btn {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 100%;
    background: #fff;
    border: 1px solid #b7b7b7;
    border-radius: 24px;
    padding: 0.6rem 1.5rem;
    font-size: 1rem;
    font-weight: 500;
    cursor: pointer;
    margin-bottom: 1rem;
    transition: all 0.2s;
    gap: 12px;
    position: relative;
}
.social-btn:hover {
    border-color: #333;
}
.social-icon {
    width: 20px;
    height: 20px;
    position: absolute;
    left: 1.2rem;
}

/* --- Bottom Links --- */
.signin-more-options, .signin-help {
    color: #1473e6;
    font-size: 0.95rem;
    text-align: left;
    text-decoration: none;
    font-weight: 500;
    margin-top: 0.5rem;
}
.signin-help {
    margin-top: 0.25rem;
}
.signin-more-options:hover, .signin-help:hover {
    text-decoration: underline;
}

/* --- Footer --- */
.signin-footer {
    position: fixed;
    left: 0;
    bottom: 0;
    width: 100%;
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 1.5rem;
    color: #fff;
    background: transparent;
    font-size: 0.85rem;
    padding: 1.2rem;
    z-index: 2;
    text-shadow: 0 1px 3px rgba(0,0,0,0.3);
}

/* --- Help Button --- */
.help-button {
    position: fixed;
    bottom: 20px;
    right: 20px;
    width: 48px;
    height: 48px;
    border-radius: 50%;
    background-color: #fff;
    border: none;
    box-shadow: 0 4px 12px rgba(0,0,0,0.2);
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #333;
    z-index: 4;
}

/* --- Responsive Design --- */
@media (max-width: 992px) {
    .signin-layout {
        flex-direction: column;
        justify-content: flex-start; /* เปลี่ยนให้เนื้อหาเริ่มจากด้านบน */
        align-items: center;
        padding: 1rem;
    }
    .signin-left {
        position: static;
        margin-top: 5vh;
        margin-bottom: 2rem;
        order: 1;
    }
    .signin-card {
        margin: 0;
        width: 100%;
        max-width: 480px;
        order: 2;
        max-height: none; /* [ยกเลิก] เมื่อหน้าจอเล็ก ให้ทั้งหน้า scroll แทน */
        overflow-y: visible; /* [ยกเลิก] */
    }
    .signin-footer {
        position: relative; /* ทำให้ footer เลื่อนตามเนื้อหา */
        margin-top: 2rem;
        padding-bottom: 2rem;
        order: 3; /* ให้ footer อยู่ล่างสุดเสมอ */
    }
}

@media (max-width: 600px) {
    .signin-layout {
        padding: 0;
    }
    .signin-left {
       margin-top: 2rem;
    }
    .signin-card {
        border-radius: 0;
        box-shadow: none;
        width: 100%;
        max-width: 100%;
    }
     .signin-content {
        padding: 1.5rem;
    }
    .signin-footer {
        flex-direction: column;
        align-items: center;
        gap: 0.8rem;
        font-size: 0.8rem;
    }
    .help-button {
        bottom: 10px;
        right: 10px;
    }
}
</style>