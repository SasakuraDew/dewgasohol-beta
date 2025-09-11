<template>
    <div class="signin-bg">
        <div class="signin-layout">
            <!-- ส่วนด้านซ้ายสำหรับโลโก้ -->
            <div class="signin-left">
                <div class="signin-adobe-logo">
                    <img src="/Image 10_12_02.png" alt="DEWGASOHOL Logo" style="width:44px; height:40px; object-fit:contain;" />
                    <div class="signin-adobe-text">
                        <span>DEWGASOHOL</span>
                        <div class="signin-adobe-desc">Sign in or create an account</div>
                    </div> 
                </div>
            </div>

            <!-- การ์ดลงทะเบียน (ส่วนด้านขวา) -->
            <div class="signin-card">
                <div class="signin-content">
                    <div class="signin-header">
                        <h2>Create an account</h2>
                        <div class="signin-newuser">Already have an account? <nuxt-link to="/deep_link/user_signin">Sign in</nuxt-link></div>
                    </div>

                    <!-- [ปรับปรุง] เพิ่ม Social Sign Up เพื่อลดขั้นตอน -->
                    <!-- <button class="social-btn">
                        <img class="social-icon" src="https://www.vectorlogo.zone/logos/google/google-icon.svg" alt="Google"/>
                        <span>Sign up with Google</span>
                    </button>
                    <div class="signin-or"><span>Or create with email</span></div> -->




                    <label class="signin-label" for="username-input">Username (Display name)</label>
                    <input id="username-input" class="signin-input" type="text" placeholder="Enter your username" v-model="username" />

                    <label class="signin-label" for="fullname-input">Full Name</label>
                    <input id="fullname-input" class="signin-input" type="text" placeholder="Enter your full name" v-model="fullname" />

                    <label class="signin-label" for="email-input">Email address</label>
                    <input id="email-input" class="signin-input" type="email" placeholder="Enter your email" v-model="email" />
                    <label class="signin-label" for="password-input">Password</label>
                    <!-- [ปรับปรุง] เพิ่ม Container สำหรับช่อง Password และปุ่ม Show/Hide -->
                    <div class="password-container">
                                                <input
                                                    id="password-input"
                                                    class="signin-input"
                                                    :type="showPassword ? 'text' : 'password'"
                                                    placeholder="Create a password"
                                                    v-model="password"
                                                />
                                                <button class="toggle-password" type="button" @click="showPassword = !showPassword">
                                                        <svg v-if="showPassword" xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path><circle cx="12" cy="12" r="3"></circle></svg>
                                                        <svg v-else xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17.94 17.94A10.06 10.06 0 0 1 12 20c-7 0-11-8-11-8a19.77 19.77 0 0 1 5.06-6.94M1 1l22 22"/><path d="M9.53 9.53A3 3 0 0 0 12 15a3 3 0 0 0 2.47-5.47"/></svg>
                                                </button>
                    </div>

                    <!-- [ใหม่] เพิ่มแถบวัดความปลอดภัยของรหัสผ่าน -->
                    <!-- <div class="password-strength">
                        <div class="strength-bar weak"></div>
                        <div class="strength-bar medium"></div>
                        <div class="strength-bar strong"></div>
                    </div> -->

                     <!-- [ใหม่] เพิ่ม Checkbox ยอมรับเงื่อนไข -->
                    <div class="terms-container">
                        <input type="checkbox" id="terms-checkbox" class="terms-checkbox" v-model="termsAccepted">
                        <label for="terms-checkbox" class="terms-label">
                            By creating an account, you agree to our <a href="#">Terms of Use</a> and <a href="#">Privacy Policy</a>.
                        </label>
                    </div>


                    <!-- [ปรับปรุง] ปุ่มจะถูก disable จนกว่าฟอร์มจะถูกต้อง -->
                    <button class="signin-continue" :disabled="!fullname || !email || !password || !termsAccepted || loading" @click="createAccount">{{ loading ? 'กำลังสมัคร...' : 'Create account' }}</button>
                                        <div v-if="message && !message.includes('Create Account successful! Redirecting...')" style="color:red; margin-top:10px">{{ message }}</div>
                                        <v-alert
                                            v-if="message && message.includes('Create Account successful! Redirecting...')"
                                            dense
                                            text
                                            type="success"
                                            icon="$mdi-check-circle"
                                            class="mb-4"
                                        >
                                            ( Create Account successful! Redirecting...)
                                        </v-alert>

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
    overflow-y: auto;
    overflow-x: hidden;
}

/* --- Layout --- */
.signin-layout {
    display: flex;
    justify-content: flex-end;
    align-items: center; /* จัดกลางเพื่อให้เห็น card สวยงาม */
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
    max-height: 90vh; /* ปรับเล็กน้อยเพื่อรองรับเนื้อหาที่เพิ่มขึ้น */
    overflow-y: auto;
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
    text-align: left; /* จัดชิดซ้าย */
}
.signin-input {
    border: 1px solid #c0c0c0;
    border-radius: 4px;
    padding: 0.75rem 0.9rem;
    font-size: 1rem;
    width: 100%;
    box-sizing: border-box;
    transition: border-color 0.2s;
}
.signin-input:focus {
    outline: none;
    border-color: #1473e6;
    box-shadow: 0 0 0 1px #1473e6;
}

/* --- [ใหม่] Password Container & Toggle Button --- */
.password-container {
    position: relative;
    display: flex;
    align-items: center;
    margin-bottom: 0.5rem; /* ลดระยะห่างด้านล่างเล็กน้อย */
}
.password-container .signin-input {
    padding-right: 40px; /* เพิ่มที่ว่างสำหรับปุ่ม */
}
.toggle-password {
    position: absolute;
    right: 10px;
    background: none;
    border: none;
    cursor: pointer;
    color: #777;
    padding: 4px;
}
.toggle-password:hover {
    color: #333;
}

/* --- [ใหม่] Password Strength Meter --- */
.password-strength {
    display: flex;
    gap: 4px;
    height: 6px;
    margin-bottom: 1.5rem;
    align-items: center;
}
.strength-bar {
    flex: 1;
    height: 100%;
    background-color: #e0e0e0;
    border-radius: 3px;
    transition: background-color 0.3s;
}
.strength-bar.weak { background-color: #f44336; }
.strength-bar.medium { background-color: #ff9800; }
.strength-bar.strong { background-color: #4caf50; }
.strength-text {
    font-size: 0.8rem;
    color: #f44336;
    margin-left: 8px;
    font-weight: 500;
}

/* --- [ใหม่] Terms and Conditions --- */
.terms-container {
    display: flex;
    align-items: flex-start;
    margin: 0 0 1.5rem 0;
}
.terms-checkbox {
    margin-top: 3px;
    margin-right: 8px;
}
.terms-label {
    font-size: 0.85rem;
    color: #555;
    text-align: left;
}
.terms-label a {
    color: #1473e6;
    text-decoration: none;
}
.terms-label a:hover {
    text-decoration: underline;
}


/* --- Continue Button --- */
.signin-continue {
    background: #1473e6;
    color: #fff;
    border: none;
    border-radius: 24px;
    padding: 0.8rem 1.5rem; /* เพิ่ม padding เล็กน้อย */
    font-size: 1rem;
    font-weight: 600;
    cursor: pointer;
    width: 100%; /* ทำให้ปุ่มเต็มความกว้าง */
    margin-top: 0.5rem;
    transition: background 0.2s, opacity 0.2s;
}
.signin-continue:hover {
    background: #0d66d0;
}
.signin-continue:disabled {
    background: #a0a0a0; /* สีเทาเมื่อใช้งานไม่ได้ */
    cursor: not-allowed;
    opacity: 0.7;
}

/* --- "Or" Separator --- */
.signin-or {
    display: flex;
    align-items: center;
    text-align: center;
    color: #888;
    margin: 1.5rem 0; /* เพิ่มระยะห่าง */
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

/* --- Footer & Help Button (เหมือนเดิม) --- */
.signin-footer {
    position: fixed; left: 0; bottom: 0; width: 100%;
    display: flex; justify-content: center; gap: 1.5rem;
    color: #fff; font-size: 0.85rem; padding: 1.2rem;
    z-index: 2; text-shadow: 0 1px 3px rgba(0,0,0,0.3);
}
.help-button {
    position: fixed; bottom: 20px; right: 20px;
    width: 48px; height: 48px; border-radius: 50%;
    background-color: #fff; border: none; box-shadow: 0 4px 12px rgba(0,0,0,0.2);
    cursor: pointer; display: flex; align-items: center; justify-content: center;
    color: #333; z-index: 4;
}

/* --- Responsive Design --- */
@media (max-width: 992px) {
    .signin-layout {
        flex-direction: column; justify-content: flex-start;
        align-items: center; padding: 1rem;
    }
    .signin-left {
        position: static; margin-top: 5vh;
        margin-bottom: 2rem; order: 1;
    }
    .signin-card {
        margin: 0; width: 100%; max-width: 480px; order: 2;
        max-height: none; overflow-y: visible;
    }
    .signin-footer {
        position: relative; margin-top: 2rem;
        padding-bottom: 2rem; order: 3;
    }
}
@media (max-width: 600px) {
    .signin-layout { padding: 0; }
    .signin-left { margin-top: 2rem; }
    .signin-card { border-radius: 0; box-shadow: none; max-width: 100%; }
    .signin-content { padding: 1.5rem; }
    .signin-footer { flex-direction: column; align-items: center; gap: 0.8rem; font-size: 0.8rem; }
    .help-button { bottom: 10px; right: 10px; }
}
</style>

<script>
export default {
    data() {
        return {
            username: '',
            fullname: '',
            email: '',
            password: '',
            showPassword: false,
            termsAccepted: false,
            loading: false,
            message: ''
        }
    },
    methods: {
        async createAccount() {
            if (!this.username || !this.fullname || !this.email || !this.password) {
                this.message = 'กรุณากรอกข้อมูลที่จำเป็นให้ครบถ้วน (Username, ชื่อ, อีเมล, รหัสผ่าน)';
                return;
            }
            if (!this.termsAccepted) {
                this.message = 'กรุณายอมรับเงื่อนไขการใช้งาน';
                return;
            }

            this.loading = true;
            this.message = '';

            try {
                const apiUrl = 'http://localhost/dewgasohol_beta/register.php';

                const response = await fetch(apiUrl, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        fullname: this.fullname,
                        display_name: this.username, // ส่ง display_name ไปด้วย
                        email: this.email,
                        password: this.password
                    })
                });

                const result = await response.json();

                if (!response.ok) {
                    throw new Error(result.message || 'เกิดข้อผิดพลาดในการสมัครสมาชิก');
                }

                this.message = 'Create Account successful! Redirecting...';
                this.username = '';
                this.fullname = '';
                this.email = '';
                this.password = '';
                this.termsAccepted = false;

                setTimeout(() => {
                    this.$router.push('/deep_link/user_signin');
                }, 2000);

            } catch (error) {
                this.message = error.message;
            } finally {
                this.loading = false;
            }
        }
    }
}
</script>
