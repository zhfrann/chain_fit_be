const allowedOrigins = [
    "http://localhost:3000",
    "http://localhost:3001",
    "https://soulspace-rust.vercel.app"
];

const corsOptions = {
    origin: function (origin, callback) {
        if (!origin || allowedOrigins.includes(origin)) {
        callback(null, true);
        } else {
        callback(new Error("Not allowed by CORS"));
        }
    },
    credentials: true,
};

export default corsOptions;