import * as React from "react";
import { Slot } from "@radix-ui/react-slot";
import { cva, type VariantProps } from "class-variance-authority";
import { cn } from "@/lib/utils";

const buttonVariants = cva(
  "inline-flex items-center justify-center gap-2 whitespace-nowrap text-sm font-semibold transition-all duration-500 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:size-4 [&_svg]:shrink-0 relative overflow-hidden",
  {
    variants: {
      variant: {
        default:
          "bg-gradient-button text-white rounded-[14px] shadow-glow hover:shadow-glow-strong hover:-translate-y-0.5 before:absolute before:inset-0 before:bg-gradient-to-r before:from-transparent before:via-white/10 before:to-transparent before:translate-x-[-200%] hover:before:translate-x-[200%] before:transition-transform before:duration-700",
        destructive:
          "bg-destructive text-destructive-foreground hover:bg-destructive/90 rounded-[14px] shadow-soft",
        outline:
          "border border-silver-dark/30 bg-transparent text-silver rounded-[14px] hover:border-primary/40 hover:text-foreground hover:bg-primary/5 backdrop-blur-sm",
        secondary:
          "bg-secondary text-secondary-foreground border border-border rounded-[14px] hover:bg-secondary/80",
        ghost:
          "text-muted-foreground hover:text-foreground hover:bg-accent/50 rounded-[14px]",
        link:
          "text-primary underline-offset-4 hover:underline",
        premium:
          "bg-gradient-button text-white rounded-[14px] shadow-glow-strong hover:shadow-[0_0_48px_rgba(36,87,255,0.35)] hover:-translate-y-1 hover:scale-[1.02]",
      },
      size: {
        default: "h-12 px-7 py-3",
        sm: "h-10 px-5 text-body-sm",
        lg: "h-14 px-10 text-base",
        xl: "h-16 px-12 text-lg",
        icon: "h-10 w-10",
      },
    },
    defaultVariants: {
      variant: "default",
      size: "default",
    },
  },
);

export interface ButtonProps
  extends React.ButtonHTMLAttributes<HTMLButtonElement>,
    VariantProps<typeof buttonVariants> {
  asChild?: boolean;
}

const Button = React.forwardRef<HTMLButtonElement, ButtonProps>(
  ({ className, variant, size, asChild = false, ...props }, ref) => {
    const Comp = asChild ? Slot : "button";
    return <Comp className={cn(buttonVariants({ variant, size, className }))} ref={ref} {...props} />;
  },
);
Button.displayName = "Button";

export { Button, buttonVariants };
