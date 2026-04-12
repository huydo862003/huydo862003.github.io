import {
  onMounted, onUnmounted, type Ref,
} from 'vue';
import {
  useRouter,
} from 'vue-router';
import {
  nodes, edges, TYPE_COLORS, nodeRoute, type GraphNode,
} from '@/utils/graph';

export function useGraph (container: Ref<HTMLElement | undefined>, height: Ref<number> | number) {
  const router = useRouter();
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  let graph: any;

  function zoomIn () {
    graph?.zoom(graph.zoom() * 1.3, 300);
  }
  function zoomOut () {
    graph?.zoom(graph.zoom() / 1.3, 300);
  }
  function zoomFit () {
    graph?.zoomToFit(400, 40);
  }
  function recenter () {
    graph?.centerAt(0, 0, 300);
    graph?.zoom(1, 300);
  }

  function handleResize () {
    if (!graph || !container.value) return;
    const h = typeof height === 'number' ? height : height.value;
    graph.width(container.value.clientWidth).height(h);
  }

  onMounted(async () => {
    if (!container.value) return;
    const {
      default: ForceGraph,
    } = await import('force-graph');
    const h = typeof height === 'number' ? height : height.value;

    // force-graph types don't match its runtime API
    graph = (ForceGraph as any)()(container.value)
      .graphData({
        nodes: nodes.map((n) => ({
          ...n,
        })),
        links: edges.map((e) => ({
          ...e,
        })),
      })
      .nodeId('id')
      .nodeLabel((n: GraphNode) => `${n.title} (${n.type})`)
      .nodeColor((n: GraphNode) => TYPE_COLORS[n.type] || '#999')
      .nodeVal((n: GraphNode) => Math.max(2, Math.sqrt(n.links + 1) * 2))
      .linkColor(() => 'rgba(255,255,255,0.06)')
      .linkWidth(0.3)
      .backgroundColor('#141414')
      .width(container.value.clientWidth)
      .height(h)
      .warmupTicks(100)
      .cooldownTicks(0)
      .onNodeClick((n: unknown) => {
        router.push(nodeRoute(n as GraphNode));
      });

    window.addEventListener('resize', handleResize);
  });

  onUnmounted(() => {
    window.removeEventListener('resize', handleResize);
    graph?._destructor?.();
  });

  return {
    zoomIn,
    zoomOut,
    zoomFit,
    recenter,
  };
}
