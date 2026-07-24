import type { Config } from "tailwindcss";

export default {
  darkMode: ["class"],
  content: ["./pages/**/*.{ts,tsx}", "./components/**/*.{ts,tsx}", "./app/**/*.{ts,tsx}", "./src/**/*.{ts,tsx}"],
  prefix: "",
  theme: {
    container: {
      center: true,
      padding: "2rem",
      screens: {
        "2xl": "1400px",
      },
    },
    extend: {
      fontFamily: {
        sans: ["Manrope", "system-ui", "-apple-system", "sans-serif"],
      },
      fontSize: {
        /* Affirm-inspired typographic scale — XL light */
        "display-xl": ["6.5rem", { lineHeight: "1.0", fontWeight: "300", letterSpacing: "-0.035em" }],
        "display": ["5rem", { lineHeight: "1.02", fontWeight: "300", letterSpacing: "-0.03em" }],
        "display-md": ["3.75rem", { lineHeight: "1.05", fontWeight: "300", letterSpacing: "-0.025em" }],
        "display-sm": ["2.75rem", { lineHeight: "1.1", fontWeight: "300", letterSpacing: "-0.02em" }],
        "heading-1": ["2.625rem", { lineHeight: "1.12", fontWeight: "400", letterSpacing: "-0.015em" }],
        "heading-2": ["2.125rem", { lineHeight: "1.15", fontWeight: "400", letterSpacing: "-0.01em" }],
        "heading-3": ["1.75rem", { lineHeight: "1.2", fontWeight: "500" }],
        "heading-4": ["1.375rem", { lineHeight: "1.25", fontWeight: "500" }],
        "body-lg": ["1.125rem", { lineHeight: "1.65", fontWeight: "400" }],
        "body": ["1rem", { lineHeight: "1.6", fontWeight: "400" }],
        "body-sm": ["0.875rem", { lineHeight: "1.55", fontWeight: "400" }],
        "label": ["0.8125rem", { lineHeight: "1.4", fontWeight: "500", letterSpacing: "0.04em" }],
        "micro": ["0.75rem", { lineHeight: "1.4", fontWeight: "500", letterSpacing: "0.05em" }],
      },
      colors: {
        border: "hsl(var(--border))",
        input: "hsl(var(--input))",
        ring: "hsl(var(--ring))",
        background: "hsl(var(--background))",
        "background-pure": "hsl(var(--background-pure))",
        foreground: "hsl(var(--foreground))",
        "foreground-soft": "hsl(var(--foreground-soft))",
        "muted-text": "hsl(var(--muted-text))",
        primary: {
          DEFAULT: "hsl(var(--primary))",
          foreground: "hsl(var(--primary-foreground))",
          light: "hsl(var(--primary-light))",
          dark: "hsl(var(--primary-dark))",
          glow: "hsl(var(--primary-glow))",
        },
        secondary: {
          DEFAULT: "hsl(var(--secondary))",
          foreground: "hsl(var(--secondary-foreground))",
        },
        neutral: {
          light: "hsl(var(--neutral-light))",
          mid: "hsl(var(--neutral-mid))",
          dark: "hsl(var(--neutral-dark))",
        },
        silver: {
          DEFAULT: "hsl(var(--silver))",
          light: "hsl(var(--silver-light))",
          dark: "hsl(var(--silver-dark))",
        },
        destructive: {
          DEFAULT: "hsl(var(--destructive))",
          foreground: "hsl(var(--destructive-foreground))",
        },
        muted: {
          DEFAULT: "hsl(var(--muted))",
          foreground: "hsl(var(--muted-foreground))",
        },
        accent: {
          DEFAULT: "hsl(var(--accent))",
          foreground: "hsl(var(--accent-foreground))",
        },
        popover: {
          DEFAULT: "hsl(var(--popover))",
          foreground: "hsl(var(--popover-foreground))",
        },
        card: {
          DEFAULT: "hsl(var(--card))",
          foreground: "hsl(var(--card-foreground))",
        },
      },
      boxShadow: {
        xs: "var(--shadow-xs)",
        soft: "var(--shadow-soft)",
        medium: "var(--shadow-medium)",
        strong: "var(--shadow-strong)",
        glow: "var(--shadow-glow)",
        "glow-strong": "var(--shadow-glow-strong)",
      },
      backgroundImage: {
        "gradient-primary": "var(--gradient-primary)",
        "gradient-hero": "var(--gradient-hero)",
        "gradient-subtle": "var(--gradient-subtle)",
        "gradient-card": "var(--gradient-card)",
        "gradient-button": "var(--gradient-button)",
      },
      backdropBlur: {
        glass: "var(--blur-glass)",
      },
      borderRadius: {
        "card": "24px",
        "button": "14px",
        lg: "var(--radius)",
        md: "calc(var(--radius) - 4px)",
        sm: "calc(var(--radius) - 8px)",
      },
      spacing: {
        "section": "8rem",
        "section-lg": "10rem",
      },
      keyframes: {
        "accordion-down": {
          from: { height: "0" },
          to: { height: "var(--radix-accordion-content-height)" },
        },
        "accordion-up": {
          from: { height: "var(--radix-accordion-content-height)" },
          to: { height: "0" },
        },
        "fade-in": {
          "0%": { opacity: "0", transform: "translateY(20px)" },
          "100%": { opacity: "1", transform: "translateY(0)" },
        },
        "slide-up": {
          "0%": { opacity: "0", transform: "translateY(28px)" },
          "100%": { opacity: "1", transform: "translateY(0)" },
        },
        "scale-in": {
          "0%": { opacity: "0", transform: "scale(0.96)" },
          "100%": { opacity: "1", transform: "scale(1)" },
        },
        "float": {
          "0%, 100%": { transform: "translateY(0)" },
          "50%": { transform: "translateY(-14px)" },
        },
        "shine": {
          "0%": { transform: "translateX(-100%)" },
          "100%": { transform: "translateX(200%)" },
        },
        "sphere-rotate": {
          "0%": { transform: "rotateX(-15deg) rotateY(0deg)" },
          "100%": { transform: "rotateX(-15deg) rotateY(360deg)" },
        },
        "fly-into-phone": {
          "0%": { opacity: "0", transform: "translateX(120%) scale(0.85) rotate(8deg)" },
          "15%": { opacity: "1" },
          "55%": { opacity: "1", transform: "translateX(0) scale(1) rotate(0deg)" },
          "85%": { opacity: "1", transform: "translateX(0) scale(1) rotate(0deg)" },
          "100%": { opacity: "0", transform: "translateX(-30%) scale(0.9) rotate(-4deg)" },
        },
        "scroll-x": {
          "0%": { transform: "translateX(0)" },
          "100%": { transform: "translateX(-50%)" },
        },
      },
      animation: {
        "accordion-down": "accordion-down 0.2s ease-out",
        "accordion-up": "accordion-up 0.2s ease-out",
        "fade-in": "fade-in 0.6s ease-out",
        "slide-up": "slide-up 0.6s ease-out",
        "scale-in": "scale-in 0.4s ease-out",
        "float": "float 5s ease-in-out infinite",
        "shine": "shine 6s linear infinite",
        "sphere-rotate": "sphere-rotate 22s linear infinite",
        "fly-into-phone": "fly-into-phone 8s ease-in-out infinite",
      },
    },
  },
  plugins: [require("tailwindcss-animate")],
} satisfies Config;
