<template>
  <div class="container">
    <h1>บัตรสมาชิก</h1>

    <!-- Digital Member Card -->
    <div class="member-card-container">
      <div class="member-card">
        <div class="card-header">
          <span class="brand-logo">DEW GASOHOL</span>
          <span class="card-tier-gold">Gold Member</span>
        </div>
        <div class="card-body">
          <div class="qr-code">
            <!-- Placeholder for QR Code -->
            <img src="https://api.qrserver.com/v1/create-qr-code/?size=100x100&data=MEMBER-123456789" alt="Member QR Code">
          </div>
          <div class="member-info">
            <p class="member-name">คุณ สมชาย ใจดี</p>
            <p class="member-id">หมายเลขสมาชิก: 123-456-7890</p>
          </div>
        </div>
        <div class="card-footer">
            <span>สแกนเพื่อสะสมแต้มหรือใช้สิทธิประโยชน์</span>
        </div>
      </div>
    </div>

    <!-- Points Balance -->
    <section class="member-section">
      <h2>ยอดคะแนนสะสม</h2>
      <div class="points-balance-card">
        <p class="points">5,420</p>
        <p class="points-label">คะแนนปัจจุบัน</p>
        <button class="view-history-btn">ดูประวัติการสะสมแต้ม</button>
      </div>
    </section>

    <!-- Membership Tier -->
    <section class="member-section">
        <h2>ระดับสมาชิก (Tier)</h2>
        <div class="tier-progress-card">
            <div class="tier-info">
                <span class="current-tier">Gold</span>
                <span class="next-tier">Platinum</span>
            </div>
            <div class="progress-bar">
                <div class="progress" style="width: 70%;"></div>
            </div>
            <p class="tier-message">ต้องการอีก <strong>2,580</strong> คะแนน เพื่อเลื่อนเป็นระดับ Platinum</p>
        </div>
    </section>

    <!-- Member Benefits -->
    <section class="member-section">
      <h2>สิทธิประโยชน์สำหรับคุณ</h2>
      <ul class="benefits-list">
        <li><i class="fas fa-gas-pump"></i> ส่วนลดค่าน้ำมัน 50 สต./ลิตร (สำหรับ Gold Tier)</li>
        <li><i class="fas fa-coffee"></i> รับส่วนลด 15% ที่ร้าน Dew Coffee</li>
        <li><i class="fas fa-birthday-cake"></i> รับเครื่องดื่มฟรีในเดือนเกิด</li>
        <li><i class="fas fa-car-crash"></i> บริการช่วยเหลือฉุกเฉินบนท้องถนน</li>
      </ul>
    </section>

    <!-- Redeem Rewards -->
    <section class="member-section">
      <h2>แลกของรางวัล</h2>
      <div class="redeem-options">
        <div class="redeem-card">
          <h4>แลกคูปองส่วนลด</h4>
          <p>ใช้คะแนนแลกเป็นคูปองส่วนลดน้ำมันและร้านค้า</p>
          <button class="redeem-btn">ไปที่หน้าแลกคูปอง</button>
        </div>
        <div class="redeem-card">
          <h4>แลกของพรีเมียม</h4>
          <p>แลกรับของรางวัลพิเศษ เช่น แก้วน้ำ, ร่ม, หรือบัตรกำนัล</p>
          <button class="redeem-btn">ดูของรางวัลทั้งหมด</button>
        </div>
      </div>
    </section>

     <!-- Account Management -->
    <section class="member-section">
        <h2>การจัดการบัญชี</h2>
        <div class="account-actions">
            <button class="action-btn">อัปเดตข้อมูลส่วนตัว</button>
            <button class="action-btn">ดูประวัติการใช้งานบัตร</button>
        </div>
    </section>

  </div>
</template>

<script>
export default {
  // No script logic needed for this static example yet
};
</script>

<style scoped>
@import url('''https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css''');

.container {
  padding: 20px;
  font-family: '''Sarabun''', sans-serif;
  background-color: #f0f2f5;
}

h1, h2 {
  color: #D4AF37; /* Gold color for headings */
  text-align: center;
}

h1 {
    margin-bottom: 30px;
}

h2 {
    margin-top: 40px;
    margin-bottom: 20px;
    border-bottom: 2px solid #D4AF37;
    padding-bottom: 10px;
    display: inline-block;
}

.member-section {
    text-align: center;
    margin-bottom: 40px;
}

/* Digital Member Card */
.member-card-container {
    display: flex;
    justify-content: center;
}
.member-card {
  width: 100%;
  max-width: 380px;
  height: 220px;
  background: linear-gradient(45deg, #1a1a1a, #333333);
  color: white;
  border-radius: 15px;
  padding: 20px;
  box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.brand-logo {
  font-weight: bold;
  font-size: 1.2em;
}

.card-tier-gold {
  background-color: #D4AF37;
  color: #333;
  padding: 5px 10px;
  border-radius: 20px;
  font-size: 0.8em;
  font-weight: bold;
}

.card-body {
    display: flex;
    align-items: center;
    gap: 20px;
}

.qr-code img {
    border-radius: 8px;
    background: white;
    padding: 5px;
}

.member-info .member-name {
  font-size: 1.1em;
  font-weight: bold;
  margin: 0;
}

.member-info .member-id {
  font-size: 0.9em;
  color: #ccc;
  margin: 5px 0 0;
}

.card-footer {
    text-align: center;
    font-size: 0.8em;
    color: #aaa;
}


/* Points Balance */
.points-balance-card {
    background: white;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0,0,0,0.05);
    max-width: 300px;
    margin: 0 auto;
}
.points {
  font-size: 3em;
  font-weight: bold;
  color: #D4AF37;
  margin: 0;
}
.points-label {
  margin: 0 0 15px;
  color: #666;
}
.view-history-btn {
    background: none;
    border: 1px solid #D4AF37;
    color: #D4AF37;
    padding: 8px 15px;
    border-radius: 5px;
    cursor: pointer;
}

/* Tier Progress */
.tier-progress-card {
    background: white;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0,0,0,0.05);
    max-width: 500px;
    margin: 0 auto;
}
.tier-info {
    display: flex;
    justify-content: space-between;
    font-weight: bold;
    margin-bottom: 10px;
}
.current-tier { color: #D4AF37; }
.next-tier { color: #b0b0b0; }

.progress-bar {
    background-color: #e9ecef;
    border-radius: 10px;
    height: 10px;
    overflow: hidden;
}
.progress {
    background-color: #D4AF37;
    height: 100%;
}
.tier-message {
    margin-top: 10px;
    font-size: 0.9em;
    color: #555;
}

/* Benefits */
.benefits-list {
  list-style: none;
  padding: 0;
  display: inline-block;
  text-align: left;
}
.benefits-list li {
  background: white;
  margin-bottom: 10px;
  padding: 15px;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0,0,0,0.05);
  display: flex;
  align-items: center;
}
.benefits-list li i {
    margin-right: 15px;
    color: #D4AF37;
    font-size: 1.5em;
    width: 30px;
    text-align: center;
}

/* Redeem Rewards & Account Actions */
.redeem-options, .account-actions {
    display: flex;
    justify-content: center;
    gap: 20px;
    flex-wrap: wrap;
}
.redeem-card {
    background: white;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0,0,0,0.05);
    width: 250px;
}
.redeem-card h4 {
    margin-top: 0;
    color: #333;
}
.redeem-btn, .action-btn {
    background-color: #D4AF37;
    color: white;
    border: none;
    padding: 10px 20px;
    border-radius: 5px;
    cursor: pointer;
    font-weight: bold;
    margin-top: 10px;
    transition: background-color 0.3s;
}
.redeem-btn:hover, .action-btn:hover {
    background-color: #b38f29;
}
.action-btn {
    background-color: #555;
}
.action-btn:hover {
    background-color: #333;
}
</style>