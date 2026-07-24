import { CSSProperties } from "react";

interface KlaryIconAnimatedProps {
  className?: string;
  style?: CSSProperties;
  /** When true, parts animate in with stagger. False = static logo. */
  animateIn?: boolean;
  /** Delay (ms) before the first part starts */
  startDelay?: number;
}

/**
 * Animated KLARY icon — inline SVG (no white background).
 * The "K" body (navy stripes + dark navy lower stripes) drops in as one block,
 * then the 4 orange petals pop in one by one.
 *
 * Source: src/assets/klary-icon.svg (viewBox 0 0 1500 1500)
 */
export const KlaryIconAnimated = ({
  className = "",
  style,
  animateIn = false,
  startDelay = 0,
}: KlaryIconAnimatedProps) => {
  const kBodyStyle: CSSProperties = animateIn
    ? {
        opacity: 0,
        transformOrigin: "30% 50%",
        animation: `kx-icon-kbody 0.95s cubic-bezier(0.34, 1.56, 0.64, 1) ${startDelay}ms forwards`,
      }
    : {};

  const petalStyle = (delay: number, originX: number, originY: number): CSSProperties =>
    animateIn
      ? {
          opacity: 0,
          transformBox: "fill-box",
          transformOrigin: "center",
          animation: `kx-icon-petal 0.65s cubic-bezier(0.34, 1.56, 0.64, 1) ${startDelay + delay}ms forwards`,
        }
      : {};

  return (
    <svg
      xmlns="http://www.w3.org/2000/svg"
      viewBox="0 0 1500 1500"
      preserveAspectRatio="xMidYMid meet"
      className={className}
      style={style}
      fill="none"
    >
      <defs>
        {/* Top cap clip for K stripes */}
        <clipPath id="kx-kcap-clip">
          <path d="M 474 332 L 1478 332 L 1478 575 L 474 575 Z" clipRule="nonzero" />
        </clipPath>
        <clipPath id="kx-kcap-clip2">
          <path d="M 1531.582 967.21 L 855.992 1373.308 L 474.621 738.859 L 1150.21 332.761 Z" clipRule="nonzero" />
        </clipPath>
        <clipPath id="kx-kcap-clip3">
          <path d="M 1985.269 694.5 L 856.5 1373 L 16.097 -25.1 L 1144.867 -703.6 Z" clipRule="nonzero" />
        </clipPath>
        {/* Petals clip */}
        <clipPath id="kx-petals-clip">
          <path d="M 892 431 L 1422 431 L 1422 1217 L 892 1217 Z" clipRule="nonzero" />
        </clipPath>
        {/* Stripes clip */}
        <clipPath id="kx-stripes-clip-a">
          <path d="M 67 150 L 873 150 L 873 745 L 67 745 Z" clipRule="nonzero" />
        </clipPath>
        <clipPath id="kx-stripes-clip-b">
          <path d="M 639 769 L 1332 769 L 1332 1373.25 L 639 1373.25 Z" clipRule="nonzero" />
        </clipPath>
        <clipPath id="kx-stripes-clip-c">
          <path d="M 469 915 L 1070 915 L 1070 1373.25 L 469 1373.25 Z" clipRule="nonzero" />
        </clipPath>
        <clipPath id="kx-stripes-clip-d">
          <path d="M 247 150 L 1434.965 150 L 1434.965 1373.25 L 247 1373.25 Z" clipRule="nonzero" />
        </clipPath>
        <clipPath id="kx-stripes-clip-e">
          <path d="M 148 150 L 1163 150 L 1163 992 L 148 992 Z" clipRule="nonzero" />
        </clipPath>
      </defs>

      {/* ───── K BODY (navy stripes + dark navy lower bars) ───── */}
      <g style={kBodyStyle}>
        {/* Top caps (#112c54) */}
        <g clipPath="url(#kx-kcap-clip)">
          <g clipPath="url(#kx-kcap-clip2)">
            <g clipPath="url(#kx-kcap-clip3)">
              <path
                fill="#112c54"
                fillRule="evenodd"
                d="M 1168.464844 108.070312 L 1354.113281 -226.730469 C 1470.066406 -162.53125 1511.945312 -16.484375 1447.644531 99.472656 L 1261.996094 434.269531 C 1146.042969 370.070312 1104.164062 224.027344 1168.464844 108.070312 Z M 550.15625 544.492188 L 1066.199219 -386.128906 L 1276.148438 -269.894531 L 876.535156 450.777344 C 812.878906 565.574219 669.027344 607.84375 553.644531 546.386719 Z M 262.238281 385.085938 L 661.855469 -335.578125 C 726.152344 -451.542969 872.277344 -493.503906 988.234375 -429.292969 L 588.617188 291.371094 C 524.964844 406.167969 381.109375 448.4375 265.726562 386.980469 Z"
              />
            </g>
          </g>
        </g>

        {/* Light navy bottom-left curve */}
        <g clipPath="url(#kx-stripes-clip-a)">
          <path
            fill="#160060"
            d="M 101.675781 744.234375 C 80.128906 633.027344 179 528.820312 180.023438 527.773438 L 180.09375 527.726562 L 872.1875 -81.59375 L 716.171875 -81.59375 L 148.898438 426.347656 C 86.078125 482.625 56.6875 565.28125 70.277344 647.460938 C 77.914062 693.523438 94.355469 729.800781 101.675781 744.234375"
          />
        </g>

        {/* Dark navy stripe 1 */}
        <g clipPath="url(#kx-stripes-clip-b)">
          <path
            fill="#01224d"
            d="M 639.421875 856.832031 L 1184.328125 1526.421875 L 1331.628906 1526.421875 L 726.914062 769.363281 L 639.421875 856.832031"
          />
        </g>

        {/* Dark navy stripe 2 */}
        <g clipPath="url(#kx-stripes-clip-c)">
          <path
            fill="#01224d"
            d="M 469.613281 1019.207031 L 876.246094 1526.421875 L 1069.425781 1526.421875 L 575.917969 915.640625 L 469.613281 1019.207031"
          />
        </g>

        {/* Light navy main K body */}
        <g clipPath="url(#kx-stripes-clip-d)">
          <path
            fill="#160060"
            d="M 533.847656 1379.757812 C 532.636719 1378.570312 531.316406 1377.25 529.96875 1375.878906 C 529.261719 1375.148438 528.511719 1374.398438 527.757812 1373.644531 C 526.914062 1372.757812 526.027344 1371.867188 525.113281 1370.933594 C 524.382812 1370.179688 523.675781 1369.449219 522.902344 1368.652344 C 501.445312 1346.351562 468.359375 1309.023438 438.648438 1263.101562 C 417.167969 1229.878906 393.796875 1188.148438 379.816406 1142.976562 C 367.414062 1082.9375 386.269531 1019.457031 430.140625 974.558594 L 1462.058594 -81.59375 L 1266.78125 -81.59375 L 335.625 843.402344 C 321.71875 857.21875 122.769531 1055.394531 371.675781 1389.492188 L 543.949219 1389.492188 C 542.011719 1387.691406 538.726562 1384.589844 534.460938 1380.347656 L 533.847656 1379.757812"
          />
        </g>

        {/* Light navy top portion of stripes */}
        <g clipPath="url(#kx-stripes-clip-e)">
          <path
            fill="#160060"
            d="M 1007.402344 -81.640625 L 1007.175781 -81.480469 L 263.84375 611.59375 L 244.191406 629.902344 C 193 677.675781 159.480469 741.519531 150.816406 809.859375 L 150.746094 810.179688 C 150.109375 814.304688 149.652344 818.363281 149.492188 822.265625 L 149.492188 822.652344 C 148.558594 834.644531 148.328125 846.820312 148.945312 859.042969 C 151.132812 901.457031 162.738281 947.289062 191.585938 991.707031 C 191.585938 991.707031 178.882812 885.632812 238.261719 825.457031 L 1161.570312 -81.160156 L 1162.117188 -81.640625 L 1007.402344 -81.640625"
          />
        </g>
      </g>

      {/* ───── ORANGE PETALS (4 individually animated) ───── */}
      <g clipPath="url(#kx-petals-clip)">
        <g clipPath="url(#kx-kcap-clip2)">
          <g clipPath="url(#kx-kcap-clip3)">
            <path
              fill="#f36b00"
              style={petalStyle(700, 1095, 525)}
              d="M 1202.359375 595.480469 C 1123.175781 643.074219 1020.429688 617.519531 972.871094 538.394531 L 941.824219 486.75 L 993.511719 455.679688 C 1072.695312 408.082031 1175.441406 433.640625 1223 512.765625 L 1254.046875 564.410156 Z"
            />
            <path
              fill="#f36b00"
              style={petalStyle(820, 985, 782)}
              d="M 947.679688 938.242188 L 916.636719 886.59375 C 869.570312 808.296875 894.183594 706.882812 971.433594 658.652344 L 973.890625 657.148438 L 1025.578125 626.078125 L 1056.621094 677.726562 C 1103.6875 756.027344 1079.074219 857.441406 1001.824219 905.667969 L 999.367188 907.175781 Z"
            />
            <path
              fill="#f36b00"
              style={petalStyle(940, 1265, 805)}
              d="M 1369.863281 874.140625 C 1290.683594 921.738281 1187.9375 896.183594 1140.375 817.058594 L 1109.328125 765.410156 L 1161.015625 734.34375 C 1240.199219 686.746094 1342.945312 712.304688 1390.503906 791.425781 L 1421.550781 843.074219 Z"
            />
            <path
              fill="#f36b00"
              style={petalStyle(1060, 1153, 1061)}
              d="M 1115.183594 1216.90625 L 1084.140625 1165.257812 C 1037.074219 1086.960938 1061.6875 985.546875 1138.9375 937.316406 L 1141.398438 935.8125 L 1193.082031 904.742188 L 1224.125 956.390625 C 1271.191406 1034.6875 1246.578125 1136.101562 1169.328125 1184.332031 L 1166.871094 1185.835938 Z"
            />
          </g>
        </g>
      </g>
    </svg>
  );
};
