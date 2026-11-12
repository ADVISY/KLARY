import { ReactNode } from "react";
import { motion, AnimatePresence } from "framer-motion";
import { cn } from "@/lib/utils";

/** Une étape du tunnel : apparaît et disparaît en glissant, jamais de saut sec. */
const FunnelStep = ({
  children,
  isActive,
  className,
}: {
  children: ReactNode;
  isActive: boolean;
  className?: string;
}) => (
  <AnimatePresence mode="wait">
    {isActive && (
      <motion.div
        initial={{ opacity: 0, y: 10 }}
        animate={{ opacity: 1, y: 0 }}
        exit={{ opacity: 0, y: -10 }}
        transition={{ duration: 0.28, ease: "easeInOut" }}
        className={cn("w-full", className)}
      >
        {children}
      </motion.div>
    )}
  </AnimatePresence>
);

export default FunnelStep;
