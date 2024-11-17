import React from 'react';
import useCount from './useCount';

interface CounterProps {
  initialValue?: number;
}

const Counter: React.FC<CounterProps> = ({ initialValue = 0 }) => {
  const { count, increment, decrement, reset } = useCount(initialValue);

  return (
    <div>
      <h1>Счетчик: {count}</h1>
      <button onClick={increment}>+</button>
      <button onClick={decrement}>-</button>
      <button onClick={reset}>Reset</button>
    </div>
  );
};

export default Counter;
