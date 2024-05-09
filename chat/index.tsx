import Events from 'events-mtaylor-io-js'
import { useEffect, useState } from 'preact/hooks'


interface UserIdentifier {
  user: string
}


interface GroupIdentifier {
  group: string
}


interface SessionIdentifier {
  session: string
}


type Identifier = UserIdentifier | GroupIdentifier | SessionIdentifier


interface Message {
  message: string
  sender: Identifier
  recipient: Identifier
}


interface ChatProps {
  events: Events
  group: string
}


export function Chat({ events, group }: ChatProps) {
  const [message, setMessage] = useState<string>('')
  const [messages, setMessages] = useState<Message[]>([])
  const recipient: Identifier = { group }
  const userId: string | undefined = events.socket.user?.id

  if (!userId) {
    return (<p class="error">Not logged in</p>)
  }

  const user: UserIdentifier = { user: userId }

  const handleMessage = (event: MessageEvent) => {
    const message: Message = JSON.parse(event.data)
    setMessages(messages => [...messages, message])
  }

  useEffect(() => {
    events.socket.onSessionMessage(handleMessage)
    events.socket.onUserMessage(userId, handleMessage)
  }, [handleMessage, events, setMessages])

  const sendMessage = () => {
    if (!message) return
    events.socket.send({ type: "message", message, recipient, sender: user })
    setMessage('')
  }

  const onChangeMessage = (event: Event) => {
    const target = event.target as HTMLInputElement
    setMessage(target.value)
  }

  return (
    <div class="chat" style={{
      position: 'fixed',
      bottom: 0,
      right: 0,
      margin: 10,
      padding: 10,
      flexBasis: '1px',
      alignSelf: 'flex-end',
    }}>
      <ul
        style={{
          margin: 0,
          padding: 0,
          listStyle: 'none',
          overflowY: 'auto',
        }}
      >
        {messages.map((message, i) => (
          <li key={i} style={{
            padding: 10,
          }}>
            {message.message}
          </li>
        ))}
      </ul>
      <input type="text" value={message} onChange={onChangeMessage} />
      <button onClick={sendMessage}>Send</button>
    </div>
  )
}
