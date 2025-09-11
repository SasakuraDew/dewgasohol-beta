<template>
  <div class="container">
    <h1>คูปอง</h1>

    <!-- Active Coupons -->
    <section class="coupons-section">
      <h2>คูปองปัจจุบัน (Active Coupons)</h2>
      <div class="coupon-list">
        <!-- Fuel Discount Coupon -->
        <div class="coupon-card">
          <div class="coupon-header">
            <h3>ส่วนลดค่าน้ำมัน 50 สต./ลิตร</h3>
          </div>
          <div class="coupon-body">
            <p><strong>เงื่อนไข:</strong> สำหรับการเติมน้ำมันชนิดใดก็ได้ครบ 800 บาทขึ้นไป</p>
            <p><strong>หมดอายุ:</strong> 31 ตุลาคม 2568</p>
            <p><strong>ข้อจำกัด:</strong> ใช้ได้ทุกสาขา ยกเว้นสาขาในสนามบิน</p>
          </div>
          <div class="coupon-footer">
            <button class="redeem-btn" @click="showQRCode('FUEL50')">ใช้คูปอง</button>
          </div>
        </div>

        <!-- Coffee Coupon -->
        <div class="coupon-card">
          <div class="coupon-header">
            <h3>ส่วนลด 20 บาท ร้านกาแฟ Dew Coffee</h3>
          </div>
          <div class="coupon-body">
            <p><strong>เงื่อนไข:</strong> เมื่อซื้อเครื่องดื่มหรือเบเกอรี่ครบ 100 บาท</p>
            <p><strong>หมดอายุ:</strong> 15 พฤศจิกายน 2568</p>
            <p><strong>ข้อจำกัด:</strong> จำกัด 1 สิทธิ์/วัน</p>
          </div>
          <div class="coupon-footer">
            <button class="redeem-btn" @click="showQRCode('COFFEE20')">ใช้คูปอง</button>
          </div>
        </div>

        <!-- Car Wash Coupon -->
        <div class="coupon-card">
          <div class="coupon-header">
            <h3>ฟรี! ล้างรถ 1 ครั้ง</h3>
          </div>
          <div class="coupon-body">
            <p><strong>เงื่อนไข:</strong> เมื่อเติมน้ำมันชนิดพรีเมียมครบ 1,200 บาท</p>
            <p><strong>หมดอายุ:</strong> 31 ธันวาคม 2568</p>
            <p><strong>ข้อจำกัด:</strong> เฉพาะสาขาที่มีบริการล้างรถ</p>
          </div>
          <div class="coupon-footer">
            <button class="redeem-btn" @click="showQRCode('CARWASHFREE')">ใช้คูปอง</button>
          </div>
        </div>
      </div>
    </section>

    <!-- Expired Coupons -->
    <section class="coupons-section">
      <h2>คูปองที่หมดอายุแล้ว (Expired Coupons)</h2>
      <div class="coupon-list">
        <div class="coupon-card expired">
          <div class="coupon-header">
            <h3>ส่วนลดค่าน้ำมัน 30 สต./ลิตร</h3>
          </div>
          <div class="coupon-body">
            <p><strong>หมดอายุ:</strong> 31 สิงหาคม 2568</p>
          </div>
        </div>
      </div>
    </section>

    <!-- Recommended Promotions -->
    <section class="coupons-section">
      <h2>โปรโมชั่นใหม่แนะนำ</h2>
       <div class="coupon-card special-offer">
          <div class="coupon-header">
            <h3>พิเศษ! เติมน้ำมันครบ 1,000 บาท รับน้ำดื่มฟรี!</h3>
          </div>
          <div class="coupon-body">
            <p>โปรโมชั่นสุดคุ้มสำหรับสมาชิกคนพิเศษเช่นคุณ</p>
             <p><strong>หมดอายุ:</strong> 30 พฤศจิกายน 2568</p>
          </div>
           <div class="coupon-footer">
            <button class="redeem-btn">ดูรายละเอียด</button>
          </div>
        </div>
    </section>

    <!-- QR Code Modal -->
    <div v-if="qrCodeValue" class="modal-overlay" @click="closeQRCode">
      <div class="modal-content" @click.stop>
        <h3>สแกน QR Code เพื่อใช้คูปอง</h3>
        <div class="qr-code-container">
            <!-- In a real app, you would generate a QR code here -->
            <img :src="`https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=${qrCodeValue}`" alt="QR Code">
        </div>
        <p>กรุณาแสดง QR Code นี้ให้แคชเชอร์สแกน</p>
        <button @click="closeQRCode" class="close-btn">ปิด</button>
      </div>
    </div>

  </div>
</template>

<script>
export default {
  data() {
    return {
      qrCodeValue: null,
    };
  },
  methods: {
    showQRCode(couponId) {
      this.qrCodeValue = `COUPON_REDEEM:${couponId}:${Date.now()}`;
    },
    closeQRCode() {
      this.qrCodeValue = null;
    },
  },
};
</script>

<style scoped>
.container {
  padding: 20px;
  font-family: 'Sarabun', sans-serif; /* Using a common Thai font */
  background-color: #f4f7f6;
}

h1, h2 {
  color: #003366; /* Dark blue for headings */
}

h1 {
    text-align: center;
    margin-bottom: 30px;
}

h2 {
    border-bottom: 2px solid #0059b3;
    padding-bottom: 10px;
    margin-top: 40px;
}

.coupons-section {
  margin-bottom: 40px;
}

.coupon-list {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 20px;
}

.coupon-card {
  background: #fff;
  border-radius: 10px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  display: flex;
  flex-direction: column;
  transition: transform 0.2s;
}

.coupon-card:hover {
    transform: translateY(-5px);
}

.coupon-header {
  background-color: #0059b3; /* PTT Blue */
  color: white;
  padding: 15px;
  border-top-left-radius: 10px;
  border-top-right-radius: 10px;
}

.coupon-header h3 {
  margin: 0;
  font-size: 1.2em;
}

.coupon-body {
  padding: 15px;
  flex-grow: 1;
}

.coupon-body p {
  margin: 0 0 10px;
  font-size: 0.95em;
  color: #333;
}

.coupon-body p strong {
    color: #003366;
}

.coupon-footer {
  padding: 15px;
  text-align: center;
  border-top: 1px dashed #ccc;
}

.redeem-btn {
  background-color: #ffc107; /* Yellow/Gold */
  color: #333;
  border: none;
  padding: 10px 20px;
  border-radius: 5px;
  cursor: pointer;
  font-weight: bold;
  font-size: 1em;
  transition: background-color 0.3s;
}

.redeem-btn:hover {
  background-color: #e0a800;
}

/* Expired Coupon Style */
.coupon-card.expired {
  opacity: 0.6;
  background-color: #e9ecef;
}

.coupon-card.expired .coupon-header {
    background-color: #6c757d; /* Gray */
}

/* Special Offer Style */
.coupon-card.special-offer .coupon-header {
    background-color: #28a745; /* Green */
}


/* Modal for QR Code */
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.7);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 1000;
}

.modal-content {
  background: white;
  padding: 30px;
  border-radius: 10px;
  text-align: center;
  max-width: 90%;
  width: 350px;
}

.qr-code-container {
    margin: 20px 0;
}

.close-btn {
    margin-top: 15px;
    background-color: #dc3545;
    color: white;
    border: none;
    padding: 10px 20px;
    border-radius: 5px;
    cursor: pointer;
}
</style>