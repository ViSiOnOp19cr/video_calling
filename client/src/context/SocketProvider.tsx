import { createContext, useContext, useMemo } from "react";
import { io, Socket } from "socket.io-client";

const SocketContext = createContext<Socket | null>(null);

export const useSocket = ()=>{
    const socket = useContext(SocketContext);
    return socket;
}
export const SocketProvider = ({children}:{children:React.ReactNode})=>{
    const socket = useMemo(()=>{
        const serverUrl = import.meta.env.PROD 
            ? "https://videocall.chandancr.xyz" 
            : "http://localhost:8000";
            
        const newSocket = io(serverUrl, {
            extraHeaders: {
                "ngrok-skip-browser-warning": "true"
            }
        });
        return newSocket;
    },[])

    return <SocketContext.Provider value={socket}>{children}</SocketContext.Provider>
}

