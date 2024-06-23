import styles from "./ConnectingScreen.module.css";

export default function ConnectingScreen() {
    return (
        <div className={styles.screen}>
            <div className={styles.title}>Connecting...</div>
            <div className={styles.content}>Make sure you have the daemon running on your computer.</div>
        </div>
    )
}