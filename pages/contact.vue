<template>
    <v-container class="py-12">
        <v-row justify="center">
            <v-col cols="12" md="8" lg="6">
                <v-card>
                    <v-card-title class="vintage">
                        ติดต่อเรา
                    </v-card-title>
                    <v-card-text>
                        <v-form>
                            <v-text-field
                                label="ชื่อของคุณ"
                                required
                                prepend-icon="mdi-account"
                            ></v-text-field>
                            <v-text-field
                                label="อีเมล"
                                required
                                prepend-icon="mdi-email"
                                type="email"
                            ></v-text-field>
                            <v-text-field
                                label="เบอร์โทรศัพท์"
                                prepend-icon="mdi-phone"
                                type="tel"
                            ></v-text-field>
                            <v-textarea
                                label="ข้อความ"
                                required
                                prepend-icon="mdi-message"
                                rows="4"
                            ></v-textarea>
                            <v-btn color="primary" class="mt-4" block>
                                ส่งข้อความ
                            </v-btn>
                        </v-form>
                    </v-card-text>
                </v-card>
                <v-card class="mt-6">
                    <v-card-title class="subtitle-1">
                        ข้อมูลติดต่อ
                    </v-card-title>
                    <v-card-text>
                        <div>
                            <v-icon left>mdi-map-marker</v-icon>
                            123 ถนนสุขุมวิท, กรุงเทพฯ 10110
                        </div>
                        <div>
                            <v-icon left>mdi-phone</v-icon>
                            02-123-4567
                        </div>
                        <div>
                            <v-icon left>mdi-email</v-icon>
                            info@example.com
                        </div>
                    </v-card-text>
                </v-card>
            </v-col>
        </v-row>
    </v-container>
</template>

<script>
export default {
    name: 'ContactPage',
}
</script>