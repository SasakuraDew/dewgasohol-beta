<template>
	<div class="parallax-container">
		<div class="parallax-background-news"></div>
		<div class="content-section">
			<v-container>
				<v-row align="center" justify="center" class="hero-section text-center">
					<v-col cols="12">
						<h1 class="display-2 font-weight-bold white--text text-shadow">ข่าวน้ำมันและเศรษฐกิจ</h1>
						<p class="headline white--text text-shadow mt-4">อัปเดตข่าวสารล่าสุดจากทั่วโลก</p>
					</v-col>
				</v-row>
				<v-row>
					<v-col v-for="article in articles" :key="article.url" cols="12" md="6" lg="4">
						<v-card class="news-card" color="rgba(255,255,255,0.95)">
							<v-img :src="article.urlToImage || fallbackImg" height="200px" class="news-img"></v-img>
							<v-card-title class="black--text">{{ article.title }}</v-card-title>
							<v-card-subtitle class="grey--text">{{ formatDate(article.publishedAt) }}</v-card-subtitle>
							<v-card-text>{{ article.description }}</v-card-text>
							<v-card-actions>
								<v-btn :href="article.url" target="_blank" color="primary" text>อ่านต่อ</v-btn>
							</v-card-actions>
						</v-card>
					</v-col>
				</v-row>
			</v-container>
		</div>
	</div>
</template>

<script>
export default {
    data() {
        return {
            articles: [],
            fallbackImg: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?q=80&w=2070&auto=format&fit=crop',
        };
    },
    async mounted() {
        const apiKey = '97c5c6cf7ffc487c87f5e180ffa40af7'; // **สำคัญ:** ควรเปลี่ยนเป็น API Key ของคุณเอง
        const url = `https://newsapi.org/v2/everything?q=oil%20OR%20gasoline%20OR%20petrol%20OR%20economy&language=th,en&sortBy=publishedAt&pageSize=18&apiKey=${apiKey}`;

        try {
            const res = await fetch(url);

            // --- เพิ่มส่วนนี้เข้าไป ---
            // ตรวจสอบว่า API response สำเร็จหรือไม่ (HTTP status 200-299)
            if (!res.ok) {
                // ถ้าไม่สำเร็จ ให้โยน Error เพื่อให้ไปทำงานใน catch block
                const errorData = await res.json();
                throw new Error(`API Error: ${res.status} - ${errorData.message}`);
            }
            // --- จบส่วนที่เพิ่ม ---

            const data = await res.json();

            // ตรวจสอบ status ใน body ของ response ด้วยเพื่อความแน่นอน
            if (data.status === 'ok' && Array.isArray(data.articles)) {
                this.articles = data.articles.filter(a => a.title && a.url);
            } else {
                // ถ้า status ไม่ใช่ 'ok' ให้ใช้ข้อมูลสำรอง
                console.error('API response status is not "ok":', data.message);
                this.articles = this.getMockArticles();
            }
        } catch (e) {
            // --- เพิ่ม console.error เข้าไปดูสาเหตุ ---
            console.error('An error occurred while fetching news:', e);
            this.articles = this.getMockArticles(); // ใช้ข้อมูลสำรองเมื่อเกิด Error
        }
    },
    methods: {
        getMockArticles() {
            // ... (ส่วนนี้เหมือนเดิม)
            return [
                {
                    title: 'ราคาน้ำมันโลกปรับตัวสูงขึ้น หลังโอเปกลดกำลังการผลิต (Mock)',
                    description: 'ราคาน้ำมันดิบในตลาดโลกปรับตัวสูงขึ้นกว่า 5% หลังกลุ่มโอเปกประกาศลดกำลังการผลิต ส่งผลต่อต้นทุนพลังงานทั่วโลก',
                    url: '#',
                    urlToImage: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?q=80&w=2070&auto=format&fit=crop',
                    publishedAt: '2025-09-08T08:00:00Z',
                },
                {
                    title: 'เศรษฐกิจโลกชะลอตัว นักลงทุนจับตานโยบายการเงิน (Mock)',
                    description: 'นักวิเคราะห์คาดการณ์เศรษฐกิจโลกปีนี้จะชะลอตัวจากปัจจัยเงินเฟ้อและอัตราดอกเบี้ยที่สูงขึ้น',
                    url: '#',
                    urlToImage: 'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=1500&q=80',
                    publishedAt: '2025-09-07T12:30:00Z',
                },
            ];
        },
        formatDate(dateStr) {
            if (!dateStr) return '';
            const d = new Date(dateStr);
            return d.toLocaleDateString('th-TH', { year: 'numeric', month: 'short', day: 'numeric' });
        },
    },
};
</script>

<style scoped>
.parallax-container {
	position: relative;
	width: 100%;
	min-height: 100vh;
}
.parallax-background-news {
	position: fixed;
	top: 0;
	left: 0;
	width: 100vw;
	height: 100vh;
	background-image: url('https://images.unsplash.com/photo-1506744038136-46273834b3fb?q=80&w=2070&auto=format&fit=crop');
	background-size: cover;
	background-position: center;
	z-index: 1;
	filter: brightness(0.7);
}
.content-section {
	position: relative;
	z-index: 2;
	padding-top: 50px;
	padding-bottom: 50px;
}
.hero-section {
	height: 30vh;
	display: flex;
	flex-direction: column;
	justify-content: center;
}
.text-shadow {
	text-shadow: 2px 2px 4px rgba(0,0,0,0.6);
}
.news-card {
	margin-bottom: 32px;
	min-height: 420px;
	display: flex;
	flex-direction: column;
}
.news-img {
	object-fit: cover;
}
</style>
