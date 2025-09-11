export default function ({ store, redirect }) {
  // ตรวจสอบว่าผู้ใช้ล็อกอินหรือยัง และมีข้อมูลใน store หรือไม่
  const loggedInUser = store.state.auth.user;

  // เงื่อนไขที่ 1: ยังไม่ได้ล็อกอิน (ไม่มีข้อมูล user ใน store)
  // เงื่อนไขที่ 2: ล็อกอินแล้ว แต่ตำแหน่งไม่ใช่ 'admin'
  if (!loggedInUser || loggedInUser.position !== 'admin') {
    // ถ้าไม่ตรงตามเงื่อนไข ให้ redirect ไปที่หน้า blank
    return redirect('/blank');
  }

  // ถ้าเป็น admin ให้ปล่อยผ่าน เข้าหน้าได้ตามปกติ
}
