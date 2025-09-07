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
                        <div class="signin-newuser">New user? <a href="#">Create an account</a></div>
                    </div>

                    <label class="signin-label" for="email-input">Email address</label>
                    <input id="email-input" class="signin-input" type="email" />

                    <label class="signin-label" for="email-input">Password</label>
                    <input id="email-input" class="signin-input" type="email" />

                    <button class="signin-continue">Continue</button>

                    <a class="signin-more-options" href="#">More sign-in options</a>
                    <a class="signin-help" href="#">Get help signing in</a>
                </div>
            </div>
        </div>

        <footer class="signin-footer">
            <span>Copyright © 2025 DEWGASOHOL. All rights reserved.</span>
            <a href="#">Terms of Use</a>
            <a href="#">Cookie preferences</a>
            <a href="#">Privacy</a>
            <a href="#">Do not sell or share my personal information</a>
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
    justify-content: flex-end; /* [แก้ไข] ดันการ์ดไปทางขวาเป็นหลัก */
    align-items: flex-start;
    min-height: 100vh; /* [แก้ไข] ใช้ min-height เพื่อความยืดหยุ่น */
    width: 100%;
    padding: 2rem; /* [เพิ่ม] เพิ่ม padding รอบๆ */
    box-sizing: border-box;
    position: relative;
    z-index: 2;
}

/* --- Logo (Left Side) --- */
.signin-left {
    position: absolute;
    bottom: 60px; /* [แก้ไข] ยึดตำแหน่งด้านล่างคงที่ */
    left: 60px;   /* [แก้ไข] ยึดตำแหน่งด้านซ้ายคงที่ */
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
    text-shadow: 0 1px 3px rgba(0,0,0,0.3); /* [เพิ่ม] ใส่เงาให้ข้อความพื้นหลัง */
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
    /* [แก้ไข] ใช้ margin ที่ยืดหยุ่นและเหมาะสม */
    margin: 8vh 5vw 0 0; 
    display: flex;
    flex-direction: column;
    overflow: hidden;
    z-index: 3;
}

.signin-info-bar {
    background: #1473e6;
    color: #fff;
    font-size: 0.95rem;
    padding: 1rem 1.2rem;
    font-weight: 500;
    display: flex;
    align-items: center;
    gap: 10px;
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
.facebook-btn { color: #1877f2; }
.line-btn { color: #00c300; }

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
.signin-footer a {
    color: #fff;
    text-decoration: none;
}
.signin-footer a:hover {
    text-decoration: underline;
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

/* --- [ใหม่] Responsive Design --- */

/* สำหรับจอขนาดเล็กถึงกลาง (เช่น Laptop 1366px) */
@media (max-width: 1400px) {
    .signin-card {
        margin-top: 10vh;
        margin-right: 4vw;
    }
    .signin-left {
        left: 4vw;
        bottom: 40px;
    }
}


/* สำหรับจอ Tablet แนวตั้ง และจอที่เล็กกว่า */
@media (max-width: 992px) {
    .signin-layout {
        flex-direction: column; /* เปลี่ยนเป็นแนวตั้ง */
        justify-content: flex-start;
        align-items: center; /* จัดทุกอย่างไว้ตรงกลาง */
        padding: 1rem;
    }
    .signin-left {
        position: static; /* ยกเลิกการยึดตำแหน่ง */
        margin-top: 5vh;
        margin-bottom: 2rem;
        order: 1; /* ให้โลโก้อยู่ก่อน */
    }
    .signin-card {
        margin: 0;
        width: 100%;
        max-width: 480px; /* จำกัดความกว้างสูงสุด */
        order: 2; /* ให้การ์ดอยู่ทีหลัง */
    }
    .signin-footer {
        position: relative; /* ทำให้ footer เลื่อนตามเนื้อหา */
        margin-top: 2rem;
        padding-bottom: 2rem;
    }
}

/* สำหรับจอมือถือ */
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
